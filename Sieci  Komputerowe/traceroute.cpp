#include <sys/socket.h>
#include <iostream>
#include <netinet/in.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/ip_icmp.h>
#include <unistd.h>
#include <cassert>
#include <chrono>
#include <poll.h>
#include <vector>
#include <unordered_set>
#include <iomanip>

// Constants
static constexpr int RECV_TIMEOUT_MS = 1000;
static constexpr int NUMBER_OF_PACKETS = 3;
static constexpr int MAX_TTL = 30;

// Response packet structure
struct ResponsePacket {
    std::string ip;
    int time;
};

// Function to compute ICMP checksum
uint16_t compute_icmp_checksum(const void *buff, int length) {
    const uint16_t* ptr = static_cast<const uint16_t*>(buff);
    uint32_t sum = 0;
    assert (length % 2 == 0);
    for (; length > 0; length -= 2)
        sum += *ptr++;
    sum = (sum >> 16U) + (sum & 0xffffU);
    return ~(sum + (sum >> 16U));
}

// Function to send ICMP echo request
int send_echo_request(int socket_fd, struct sockaddr_in& dest_addr, int ttl, int sequence) {
    struct icmp icmp_header;

    // Fill in ICMP header
    icmp_header.icmp_type = ICMP_ECHO; // Type 8
    icmp_header.icmp_code = 0;
    icmp_header.icmp_id = htons(getpid() & 0xffff);
    icmp_header.icmp_seq = htons(sequence);
    icmp_header.icmp_cksum = 0;
    icmp_header.icmp_cksum = compute_icmp_checksum(reinterpret_cast<uint16_t*>(&icmp_header), sizeof(icmp_header));

    if (setsockopt(socket_fd, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl )) < 0) {
        std::cerr << "main: Error setting TTL option!" << std::endl;
        return -1;
    }

    ssize_t bytes_sent = sendto(socket_fd, &icmp_header, sizeof(icmp_header), 0, 
                                 reinterpret_cast<struct sockaddr*>(&dest_addr), sizeof(dest_addr));

    if (bytes_sent < 0) {
        std::cerr << "send_echo_request: Error while sending packet!" << std::endl;
    }
    return 0;
}

// Function to receive ICMP echo response
std::vector<ResponsePacket> receive_response(int socket_fd) {
    auto start_time = std::chrono::high_resolution_clock::now();
    
    struct pollfd ps;
    ps.fd = socket_fd;
    ps.events = POLLIN;
    ps.revents = 0;
    
    std::vector<ResponsePacket> responses;
    int received_responses = 0;
    
    while (received_responses < NUMBER_OF_PACKETS) {
        // Timeout
        double remaining_time = RECV_TIMEOUT_MS - std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::high_resolution_clock::now() - start_time).count();
        if (remaining_time <= 0) {
            break;
        }

        int ready = poll(&ps, 1, RECV_TIMEOUT_MS);

        // Check poll status
        if (ready < 0) {
            std::cerr << "receive_response: Error in poll!" << std::endl;
            break;
        } else if (ready == 0) {
            break;
        }
        // ready is non-zero, so data is available to read
        if (ps.revents == POLLIN) {
            ResponsePacket response;
            
            uint8_t buffer[IP_MAXPACKET];
            struct sockaddr_in recv_addr;
            socklen_t recv_addr_len = sizeof(recv_addr);
            
            ssize_t bytes_received = recvfrom(socket_fd, buffer, IP_MAXPACKET, MSG_DONTWAIT, 
                                            reinterpret_cast<struct sockaddr*>(&recv_addr), &recv_addr_len);
                                            
            if (bytes_received < 0) {
                std::cerr << "receive_response: Error while receiving packet!" << std::endl;
            } else {
                struct ip* ip_header_reply = reinterpret_cast<struct ip*>(buffer);
                int ip_header_reply_len = ip_header_reply->ip_hl << 2;
                struct icmp* icmp_header_reply = reinterpret_cast<struct icmp*>(buffer + ip_header_reply_len);

                if (icmp_header_reply->icmp_type == ICMP_ECHOREPLY) {
                    if (icmp_header_reply->icmp_id == htons(getpid() & 0xffff)) {
                        response.ip = inet_ntoa(ip_header_reply->ip_src);
                        response.time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - start_time).count();
                        responses.push_back(response);
                        received_responses++;
                    }
                }
                else if (icmp_header_reply->icmp_type == ICMP_TIMXCEED) {
                    // Extract the original IP header and ICMP header from the response
                    struct ip* original_ip_header = reinterpret_cast<struct ip*>(buffer + ip_header_reply_len + 8);
                    int original_ip_header_len = original_ip_header->ip_hl << 2;
                    struct icmp* original_icmp_header = reinterpret_cast<struct icmp*>(buffer + ip_header_reply_len + 8 + original_ip_header_len);
                                        
                    if (original_icmp_header->icmp_type == ICMP_ECHO && 
                        original_icmp_header->icmp_id == htons(getpid() & 0xffff)) {
                        response.ip = inet_ntoa(ip_header_reply->ip_src);
                        response.time = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::high_resolution_clock::now() - start_time).count();
                        responses.push_back(response);
                        received_responses++;
                    }
                }
            }
        }
    }
    return responses;
}

// Function to display the responses
void display_responses(std::vector<ResponsePacket> responses, int ttl) {
    std::cout << std::setw(2) << std::right<<  ttl << ". ";
    if (responses.size() == 0) {
        std::cout << "*" << std::endl;
    } else {
        double avg_time = 0;
        std::unordered_set<std::string> unique_ips;

        for (const auto& response : responses) {
            avg_time += response.time;
            unique_ips.insert(response.ip);
        }
        avg_time /= responses.size();
        
        for (const auto& ip : unique_ips) {
            std::cout << std::setw(17) << std::left << ip; 
        }
        
        if (responses.size() == 3) {
            std::cout << std::setw(6) << std::fixed << std::setprecision(2) <<avg_time/1000  << "ms" << std::endl;
        } else {
            std::cout << "???" << std::endl;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <destination_ip>" << std::endl;
        return 1;
    }
    std::string destination_ip = argv[1];

    struct sockaddr_in sa;
    int result = inet_pton(AF_INET, destination_ip.c_str(), &(sa.sin_addr));
    if (result != 1) {
        std::cerr << "main: Incorrect IP address! " << destination_ip << std::endl;
        return 1;
    }

    int socket_fd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
    struct sockaddr_in dest_addr;

    if (socket_fd < 0) {
        std::cerr << "main: Error while creating socket! (probably missing sudo)" << std::endl;
        return 1;
    }

    // Zero out the destination address structure
    memset(&dest_addr, 0, sizeof(dest_addr));

    dest_addr.sin_family = AF_INET;
    dest_addr.sin_addr.s_addr = inet_addr(destination_ip.c_str());

    // Main loop
    for (int ttl = 1; ttl <= MAX_TTL; ttl++) {
        for (int i = 1; i <= NUMBER_OF_PACKETS; i++) {
            int status = send_echo_request(socket_fd, dest_addr, ttl, ttl + i);
            if (status != 0) {
                return 1;
            }
        }
        
        auto responses = receive_response(socket_fd);
        display_responses(responses, ttl);

        if (responses.size() > 0 && responses[0].ip == destination_ip) {
            break;
        }
    }

    close(socket_fd);
    return 0;
}
