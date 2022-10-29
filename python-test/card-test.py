"""
Tests a Neotron Expansion card in Slot 3.
"""

import board
import sdcardio
import storage
import digitalio
import busio
import os
import time

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT
spi = busio.SPI(board.GP18, MOSI=board.GP19, MISO=board.GP16)

while not spi.try_lock():
    print(".")

print("Setting up MCP23S17")
# Set up MCP23S17 to select CS1
io_cs = digitalio.DigitalInOut(board.GP17)
io_cs.direction = digitalio.Direction.OUTPUT
spi.configure(baudrate=8000000, phase=0, polarity=0)
io_cs.value = False
spi.write(bytes([0x40, 0x00, 0x00])) # GPIOA is outputs
io_cs.value = True

io_cs.value = False
spi.write(bytes([0x40, 0x0D, 0xFF])) # GPIOB has pull-ups
io_cs.value = True

def set_cs_and_leds(cs, debug_leds, hdd_led):
    io_cs.value = False
    debug_leds = (debug_leds ^ 0xF) & 0x0F
    if hdd_led:
        hdd_led = 0
    else:
        hdd_led = 1
    spi.write(bytes([0x40, 0x12, (debug_leds << 4) | (hdd_led << 3) | cs]));
    io_cs.value = True

set_cs_and_leds(3, 0x00, 0)

# nOUTPUT_EN will now activate CS3
noutput_en = digitalio.DigitalInOut(board.GP21)
noutput_en.direction = digitalio.Direction.OUTPUT


print("Setting up Expansion Card")
noutput_en.value = False
spi.write(bytes([0x40, 0x00, 0x00])) # GPIOA is outputs
noutput_en.value = True

scanner = [
    0b00000000,
    0b10000000,
    0b11000000,
    0b11100000,
    0b01110000,
    0b00111000,
    0b00011100,
    0b00001110,
    0b00000111,
    0b00000011,
    0b00000001,
    0b00000000,
]
debug_leds = 0
while True:
    for leds in scanner:
        noutput_en.value = False
        # LEDs are active low, so invert the counter
        spi.write(bytes([0x40, 0x00, leds ^ 0xFF]));
        noutput_en.value = True
        time.sleep(0.05)
    for leds in reversed(scanner):
        noutput_en.value = False
        # LEDs are active low, so invert the counter
        spi.write(bytes([0x40, 0x00, leds ^ 0xFF]));
        noutput_en.value = True
        time.sleep(0.05)
    debug_leds = (debug_leds + 1) & 0x0F
    set_cs_and_leds(3, debug_leds, 0)
    time.sleep(0.2)

