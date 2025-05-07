// Błazej Molik 337364
#include <arpa/inet.h>
#include <netinet/ip.h>
#include <sys/time.h>
#include <unistd.h>

#include <chrono>
#include <cmath>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

static constexpr int TIMEOUT_MS = 10000;
static constexpr double TIMEOUT_RETRY_MS = 500.0;
static constexpr int SLIDING_WINDOW_SIZE = 1000;
static constexpr int REQUEST_PACKET_SIZE = 1000;
static constexpr int MAX_FILE_SIZE = 10000000;
static constexpr int MAX_PACKET_SIZE = IP_MAXPACKET;
static constexpr int MAX_PORT = 65535;

class UDPTransport {
private:
    std::vector<std::vector<char>> buffers; // Bufory danych dla każdego segmentu
    std::vector<bool> acknowledged; // Czy segment został odebrany
    std::vector<std::chrono::steady_clock::time_point> last_sent; // Czas ostatniego wysłania segmentu

    int socket_fd;
    struct sockaddr_in server_address;

    int last_ack = -1; // Indeks ostatnio potwierdzonego segmentu
    int file_size = 0;
    int window_limit = SLIDING_WINDOW_SIZE;
    int total_segments = 0;

    std::ofstream output_file;

    // Oblicza indeks w buforze na podstawie numeru segmentu
    int get_index(int frame) const {
        return frame % SLIDING_WINDOW_SIZE;
    }

    // Wysyła żądanie do serwera o segment danych
    void send_request(int start, int length) {
        std::string msg = "GET " + std::to_string(start) + " " + std::to_string(length) + "\n";
        sendto(socket_fd, msg.c_str(), msg.size(), 0,
               reinterpret_cast<struct sockaddr*>(&server_address), sizeof(server_address));
    }

    // Przygotowuje i wysyła żądanie dla danego segmentu
    void request_segment(int frame) {
        int start = frame * REQUEST_PACKET_SIZE;
        if (start >= file_size) {
            std::cerr << "Request out of bounds: " << start << std::endl;
            return;
        }
        // Obliczamy długość segmentu do wysłania
        // Jeśli to ostatni segment, może być krótszy
        // W przeciwnym razie długość to REQUEST_PACKET_SIZE
        int len = std::min(REQUEST_PACKET_SIZE, file_size - start);
        int idx = get_index(frame);
        last_sent[idx] = std::chrono::steady_clock::now();
        send_request(start, len);
    }

    // Odbiera pakiety z gniazda i zapisuje je w buforze, jeśli są poprawne
    void receive_packets() {
        // Ustawiamy timeout na odbieranie pakietów
        fd_set fds;
        struct timeval tv{0, TIMEOUT_MS};
        FD_ZERO(&fds);
        FD_SET(socket_fd, &fds);

        // Sprawdzamy, czy są dostępne dane do odczytu
        if (select(socket_fd + 1, &fds, nullptr, nullptr, &tv) > 0) {
            char buffer[MAX_PACKET_SIZE];
            struct sockaddr_in sender;
            socklen_t sender_len = sizeof(sender);
            ssize_t len = recvfrom(socket_fd, buffer, MAX_PACKET_SIZE, 0,
                                   reinterpret_cast<struct sockaddr*>(&sender), &sender_len);
            if (len <= 0) {
                std::cerr << "Error receiving packet" << std::endl;
                return;
            }
            if (sender.sin_addr.s_addr != server_address.sin_addr.s_addr ||
                sender.sin_port != server_address.sin_port) {
                std::cerr << "Received packet from unknown source, ignoring" << std::endl;
                return;
            }

            std::string packet(buffer, len);
            size_t pos = packet.find('\n');
            if (pos == std::string::npos) {
                std::cerr << "Invalid packet format" << std::endl;
                return;
            }
            std::string header = packet.substr(0, pos);
            int start, length;
            if (sscanf(header.c_str(), "DATA %d %d", &start, &length) != 2) {
                std::cerr << "Invalid header format" << std::endl;
                return;
            }

            // Sprawdzamy, czy segment jest w oknie przesuwającym
            // Chcemy odebrać tylko segmenty, które są w oknie
            int frame = start / REQUEST_PACKET_SIZE;
            if (frame < last_ack + 1 || frame >= last_ack + 1 + SLIDING_WINDOW_SIZE) {
                return;
            }

            // Już odebrano ten segment
            int idx = get_index(frame);
            if (acknowledged[idx]) {
                return;
            }

            // Zapisujemy odebrany segment do bufora
            buffers[idx].assign(packet.begin() + pos + 1, packet.begin() + pos + 1 + length);
            acknowledged[idx] = true;
        }
    }

    // Przesuwa okno, aby odebrać kolejne segmenty
    void advance_window() {
        while (last_ack + 1 < total_segments && acknowledged[get_index(last_ack + 1)]) {
            int idx = get_index(last_ack + 1);
            // Długość segmentu do zapisania
            // Jeśli to ostatni segment, może być krótszy
            // W przeciwnym razie długość to REQUEST_PACKET_SIZE
            int len = std::min(REQUEST_PACKET_SIZE, file_size - (last_ack + 1) * REQUEST_PACKET_SIZE);
            output_file.write(buffers[idx].data(), len);
            acknowledged[idx] = false;
            last_ack++;
        }
    }

    // Sprawdza, czy minął czas oczekiwania na potwierdzenie i ponownie wysyła segment
    void retry_timeouts() {
        for (int i = last_ack + 1; i < std::min(last_ack + 1 + window_limit, total_segments); ++i) {
            int idx = get_index(i);
            if (acknowledged[idx]) continue;
            auto now = std::chrono::steady_clock::now();
            if (std::chrono::duration_cast<std::chrono::milliseconds>(now - last_sent[idx]).count() >= TIMEOUT_RETRY_MS) {
                request_segment(i);
            }
        }
    }

public:
    UDPTransport() : socket_fd(-1) {
        buffers.resize(SLIDING_WINDOW_SIZE);
        acknowledged.resize(SLIDING_WINDOW_SIZE, false);
        last_sent.resize(SLIDING_WINDOW_SIZE);
    }

    ~UDPTransport() {
        if (socket_fd >= 0) close(socket_fd);
    }

    bool parse_input(int argc, char** argv) {
        if (argc != 5) {
            std::cerr << "Usage: " << argv[0] << " <ip> <port> <output_file> <size>" << std::endl;
            return false;
        }

        socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
        if (socket_fd < 0) {
            std::cerr << "Error creating socket: " << strerror(errno) << std::endl;
            return false;
        }

        std::string ip = argv[1];
        int port = std::stoi(argv[2]);
        if (port <= 0 || port > MAX_PORT) {
            std::cerr << "Invalid port number: " << port << std::endl;
            return false;
        }

        server_address.sin_family = AF_INET;
        int v = inet_pton(AF_INET, ip.c_str(), &(server_address.sin_addr));
        if (v != 1) {
            std::cerr << "main: Incorrect IP address! " << ip << std::endl;
            return false;
        }
        inet_pton(AF_INET, ip.c_str(), &server_address.sin_addr);
        server_address.sin_port = htons(port);

        file_size = std::stoi(argv[4]);
        if (file_size <= 0 || file_size > MAX_FILE_SIZE) {
            std::cerr << "Invalid file size: " << file_size << std::endl;
            return false;
        }

        output_file.open(argv[3], std::ios::binary);
        if (!output_file.is_open()) {
            std::cerr << "Error opening output file: " << argv[3] << std::endl;
            return false;
        }

        if (REQUEST_PACKET_SIZE * SLIDING_WINDOW_SIZE > file_size) {
            window_limit = std::ceil(static_cast<double>(file_size) / REQUEST_PACKET_SIZE);
        }
        return true;
    }

    void download_file() {
        // Wysyłamy początkowe żądania
        for (int i = 0; i < window_limit; ++i) {
            request_segment(i);
        }
        
        // Odbieramy pakiety i przesuwamy okno
        total_segments = (file_size + REQUEST_PACKET_SIZE - 1) / REQUEST_PACKET_SIZE;
        while (last_ack + 1 < total_segments) {
            receive_packets();
            advance_window();
            retry_timeouts();
        }
    }
};

int main(int argc, char* argv[]) {
    UDPTransport transport;
    if (!transport.parse_input(argc, argv)) {
        return 1;
    }
    transport.download_file();
    return 0;
}
