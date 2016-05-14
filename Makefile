# ������ ��� �������, � ���������� ��������� ����� test.hex test.bin
TARG=firmware

# ������ �� ����� ������ �������� ������, ����� ������� ��������� ������
SRCS= main.c

# ������ ��� ������ ���������������� ����� ������������� (atmega8)
MCU=attiny13

#�������� ������� 9,6 ���
F_CPU = 9600000

# ���� � ������
CC =      avr-gcc
OBJCOPY = avr-objcopy
OBJSIZE = avr-size
AVRDUDE = avrdude
RM      = rm
AVRDUDE_PARAM = -c usbasp -p t13 -y

# ����� �����������, ��� ������ F_CPU ���������� ������� �� ������� ����� �������� ����������,
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

