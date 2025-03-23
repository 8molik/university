CC = g++
CFLAGS = -Wall -Wextra -std=c++11
TARGET = traceroute

all: $(TARGET)

$(TARGET): traceroute.cpp
	$(CC) $(CFLAGS) -o $(TARGET) traceroute.cpp
	@if [ "`uname`" = "Darwin" ]; then sudo chown root:wheel $(TARGET); else sudo chown root:root $(TARGET); fi
	sudo chmod u+s $(TARGET)

clean:
	rm -f *.o

distclean:
	rm -f *.o $(TARGET)
