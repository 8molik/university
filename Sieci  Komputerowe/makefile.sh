CC = g++
CFLAGS = -Wall -Wextra -std=c++11
TARGET = traceroute

all: $(TARGET)

$(TARGET): traceroute.cpp
	$(CC) $(CFLAGS) -o $(TARGET) traceroute.cpp

clean:
	rm -f $(TARGET)
