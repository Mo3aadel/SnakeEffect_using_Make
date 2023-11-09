#Parent Makefile 
#copyrights@MohamedAdel

-include config.mk

# Variables
MCU ?= atmega32
F_CPU ?= 8000000
SRC_DIR = ./src
LIB_DIR = ./lib
INC_DIR = ./inc
BUILD_DIR = ./build

# definitions
CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size

# flags
CFLAGS = -std=gnu99 -mmcu=$(MCU) -DF_CPU=$(F_CPU) -I$(INC_DIR) -Wall
LDFLAGS = -mmcu=$(MCU) -L$(LIB_DIR)

# Source and object files
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(SRC:.c=.o)

# Header files
HEADERS = $(wildcard $(INC_DIR)/*.h)
LIBS = $(wildcard $(LIB_DIR)/*.a)

OUT = $(wildcard $(BUILD_DIR)/*.hex $(BUILD_DIR)/*.elf $(BUILD_DIR)/*.txt)

all: runMake main.elf main.o main.hex 

runMake:
	$(MAKE) -C $(LIB_DIR)

main.elf: main.o $(LIBS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
	$(SIZE) --format=avr --mcu=$(MCU) $@ > Binary_Report.txt

main.o: $(firstword $(SRC)) $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

main.hex: main.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

clean_all:
	rm -f $(LIBS) $(OUT)
 
