#Child Makefile 
#copyrights@MohamedAdel


INC_DIR = ../inc

# Toolchain definitions
CC = avr-gcc
AR = avr-ar
LIBRARY = libMDIO.a

# Compiler flags
CFLAGS = -Wall


all: $(LIBRARY)

$(LIBRARY): MDIO.o
	$(AR) rcs libMDIO.a MDIO.o

%.o: %_*.c %_*.h $(INC_DIR)/*.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.a *.o
