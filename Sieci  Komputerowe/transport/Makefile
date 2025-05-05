CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11 -O2
TARGET = transport

all: $(TARGET)

$(TARGET): transport.cpp
	$(CXX) $(CXXFLAGS) -o $(TARGET) transport.cpp

clean:
	rm -f *.o

distclean: clean
	rm -f $(TARGET)

.PHONY: all clean distclean