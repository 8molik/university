#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, char* argv[]) {
    if (argc != 5) {
        std::cerr << "Usage: " << argv[0] << " <ip> <port> <output_file> <size>" << std::endl;
        return 1;
    }

    try {
        std::string ip = argv[1];
        int port = std::stoi(argv[2]);
        std::string filename = argv[3];
        int size = std::stoi(argv[4]);
        
        if (port <= 0 || port > 65535) {
            std::cerr << "Invalid port number - must be between 0 and 65534!" << std::endl;
            return 1;
        }
        
        if (size <= 0 || size > 10000000) {
            std::cerr << "Invalid size - must be between 1 and 10.000.000!" << std::endl;
            return 1;
        }

        struct sockaddr_in sa;
        int result = inet_pton(AF_INET, ip.c_str(), &(sa.sin_addr));
        if (result != 1) {
            std::cerr << "main: Incorrect IP address! " << ip << std::endl;
            return 1;
        }
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << "!" << std::endl;
        return 1;
    }
    return 0;
}