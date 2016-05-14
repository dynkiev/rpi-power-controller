# Задаем имя проекта, в результате получатся файлы test.hex test.bin
TARG=firmware

# Задаем из каких файлов собирать проект, можно указать несколько файлов
SRCS= main.c

# Задаем для какого микроконтроллера будем компилировать (atmega8)
MCU=attiny13

#Тактовая частота 9,6 МГц
F_CPU = 9600000

# пути к файлам
CC =      avr-gcc
OBJCOPY = avr-objcopy
OBJSIZE = avr-size
AVRDUDE = avrdude
RM      = rm
AVRDUDE_PARAM = -c usbasp -p t13 -y

# Флаги компилятора, при помощи F_CPU определяем частоту на которой будет работать контроллер,
CFLAGS = -mmcu=$(MCU) -Wall -g -Os -Werror -lm  -mcall-prologues -DF_CPU=$(F_CPU)
LDFLAGS = -mmcu=$(MCU) -Wall -g -Os -Werror

OBJS = $(SRCS:.c=.o)
all: $(TARG)
$(TARG): $(OBJS)
	$(CC) $(LDFLAGS) -o $@.elf  $(OBJS) -lm
	$(OBJCOPY) -O binary -R .eeprom -R .nwram  $@.elf $@.bin
	$(OBJCOPY) -O ihex -R .eeprom -R .nwram  $@.elf $@.hex
	$(OBJSIZE) --format=avr --mcu=$(MCU) $@.elf

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

flash:	all
	$(AVRDUDE) $(AVRDUDE_PARAM) -U flash:w:firmware.hex:i

clean:
#	$(RM) -f *.elf *.bin *.hex  $(OBJS) *.map
	$(RM) -f *.elf *.bin *.hex  $(OBJS)

