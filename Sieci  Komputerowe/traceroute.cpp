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

int socket_fd = socket(AF_INET, SOCK_RAW, IPPROTO_ICMP);
struct sockaddr_in dest_addr;
const int RECV_TIMEOUT_MS = 1000;
const int NUMBER_OF_PACKETS = 3;
const int MAX_TTL = 30;

uint16_t compute_icmp_checksum(const void *buff, int length) {
    const uint16_t* ptr = static_cast<const uint16_t*>(buff);
    uint32_t sum = 0;
    assert (length % 2 == 0);
    for (; length > 0; length -= 2)
        sum += *ptr++;
    sum = (sum >> 16U) + (sum & 0xffffU);
    return ~(sum + (sum >> 16U));
}

#if defined(__APPLE__)
struct icmphdr {
    uint8_t type;
    uint8_t code;
    uint16_t checksum;
    union {
        struct {
            uint16_t id;
            uint16_t sequence;
        } echo;
    } un;
};
#define ICMP_ECHO 8
#endif
void send_echo_request(int ttl, int sequence) {
    struct icmphdr icmp_header;
    memset(&icmp_header, 0, sizeof(icmp_header));

    icmp_header.type = ICMP_ECHO; // Type 8
    icmp_header.code = 0;
    icmp_header.un.echo.id = htons(getpid() & 0xffff);
    icmp_header.un.echo.sequence = htons(sequence);
    icmp_header.checksum = compute_icmp_checksum((uint16_t*)&icmp_header, sizeof(icmp_header));

    ssize_t bytes_sent = sendto(socket_fd, &icmp_header, sizeof(icmp_header), 0, 
                                 (struct sockaddr*)&dest_addr, sizeof(dest_addr));

    if (bytes_sent < 0) {
        std::cerr << "send_echo_request: Error while sending packet!" << std::endl;
    }
}

struct ResponsePacket {
    std::string ip;
    int time;
};

std::vector<ResponsePacket> receive_response() {
    auto start_time = std::chrono::high_resolution_clock::now();
    int received_responses = 0;

    struct pollfd ps;
    ps.fd = socket_fd;
    ps.events = POLLIN;
    ps.revents = 0;

    std::vector<ResponsePacket> responses;
    
    while (received_responses < NUMBER_OF_PACKETS) {
        int remaining_time = RECV_TIMEOUT_MS - std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::high_resolution_clock::now() - start_time).count();
        
        if (remaining_time <= 0) {
            break;
        }

        int ready = poll(&ps, 1, RECV_TIMEOUT_MS);

        if (ready < 0) {
            std::cerr << "Error in poll" << std::endl;
            break;
        } else if (ready == 0) {
            break;
        }

        if (ps.revents == POLLIN) {
            ResponsePacket response;
            uint8_t buffer[IP_MAXPACKET];
            struct sockaddr_in recv_addr;
            socklen_t recv_addr_len = sizeof(recv_addr);
            
            ssize_t bytes_received = recvfrom(socket_fd, buffer, IP_MAXPACKET, MSG_DONTWAIT, 
                                            (struct sockaddr*)&recv_addr, &recv_addr_len);
                                            
            if (bytes_received < 0) {
                std::cerr << "receive_response: Error while receiving packet!" << std::endl;
            } else {
                received_responses++;
                response.ip = inet_ntoa(recv_addr.sin_addr);
                response.time = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::high_resolution_clock::now() - start_time).count();
            }
            responses.push_back(response);
        }
    }
    return responses;
}

int main() {
    std::string destination_ip = "8.8.8.8";
    if (socket_fd < 0) {
        std::cerr << "Error while creating socket" << std::endl;
        return 1;
    }
    memset(&dest_addr, 0, sizeof(dest_addr));

    dest_addr.sin_family = AF_INET;
    dest_addr.sin_addr.s_addr = inet_addr(destination_ip.c_str());

    for (int ttl = 1; ttl <= MAX_TTL; ttl++) {
        if (setsockopt(socket_fd, IPPROTO_IP, IP_TTL, &ttl, sizeof(ttl)) < 0) {
            std::cerr << "Error setting TTL option" << std::endl;
            return 1;
        }

        for (int i = 1; i <= NUMBER_OF_PACKETS; i++) {
            send_echo_request(ttl, i);
        }
        
        auto responses = receive_response();

        if (responses.size() == 0) {
            std::cout << ttl << "  * * *  Request timed out." << std::endl;
        } else { 
            std::cout << responses[0].time << "  " << responses[0].ip << std::endl;
            if (responses[0].ip == destination_ip) {
                return 0;
            }
        }
    }

    return 0;
}