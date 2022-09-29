"""
Tests an SD Card in the slot, the debug LEDs on the IO chip, and WAV playback
on the audio codec.
"""

import board
import sdcardio
import storage
import digitalio
import busio
import time
from adafruit_bus_device.i2c_device import I2CDevice
import audiobusio
import audiocore
import math
import array
import os

led = digitalio.DigitalInOut(board.LED)
led.direction = digitalio.Direction.OUTPUT
i2c = busio.I2C(board.GP15, board.GP14)
# BCLK, LRC, DATA
audio = audiobusio.I2SOut(board.GP27, board.GP28, board.GP26)

spi = busio.SPI(board.GP18, MOSI=board.GP19, MISO=board.GP16)

class Codec:
    CODEC_ADDR = 0x1A

    LeftLineInputChannelVolumeControl = 0
    RightLineInputChannelVolumeControl = 1
    LeftChannelHeadphoneVolumeControl = 2
    RightChannelHeadphoneVolumeControl = 3
    AnalogAudioPathControl = 4
    DigitalAudioPathControl = 5
    PowerDownControl = 6
    DigitalAudioInterfaceFormat = 7
    SampleRateControl = 8
    DigitalInterfaceActivation = 9
    Reset = 15
    
    def __init__(self, i2c):
        self.dev = I2CDevice(i2c, self.CODEC_ADDR)


    def write(self, reg_addr, value):
        with self.dev:
            data = bytearray([(reg_addr << 1) | (value >> 8) & 1, value & 0xFF])
            self.dev.write(data)

print("Configuring CODEC")
codec = Codec(i2c)
codec.write(codec.Reset, 0x00)
codec.write(codec.LeftLineInputChannelVolumeControl, 0x1F) # 0x17 = 0dB, not muted
codec.write(codec.RightLineInputChannelVolumeControl, 0x1F) # 0x17 = 0dB, not muted
codec.write(codec.LeftChannelHeadphoneVolumeControl, 0xFF)
codec.write(codec.RightChannelHeadphoneVolumeControl, 0xFF)
# STA2    STA1 STA0 STE DAC    BYP INSEL MICM MICB
#  0       0    0    0   1      1   0     1     0 - Line in with bypass (18)
#  1       0    0    1   1      0   0     1     0 - Line in with sidetone (132)
#  0       0    0    1   1      0   1     0     1 - Microphone in sidetone (35)
codec.write(codec.AnalogAudioPathControl, 0x35)
codec.write(codec.DigitalAudioPathControl, 0x00)
codec.write(codec.PowerDownControl, 0x00)
# x x MS LRSWAP LRP IWL1 IWL0 FOR1 FOR0
# 0 0  0      0   0    0    0    1    0
codec.write(codec.DigitalAudioInterfaceFormat, 0x02)
# x CLKOUT CLKIN SR3 SR2 SR1 SR0 BOSR USB/Normal
# 0      0     0   1   0   0   0    1          1
codec.write(codec.SampleRateControl, 0x23)
codec.write(codec.DigitalInterfaceActivation, 0x01)
print("CODEC configured")

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

io_cs.value = False
cs = 1
debug_leds = 0x15
spi.write(bytes([0x40, 0x12, debug_leds << 3 | cs]));
io_cs.value = True

wave_file = open("CantinaBand3.wav", "rb")
wav = audiocore.WaveFile(wave_file)
print("Playing wav file!")
audio.play(wav)
while audio.playing:
    pass
print("Done!")

spi.unlock()

# nOUTPUT_EN will now activate CS1
cs = board.GP21


print("Mounting SD card")
sdcard = sdcardio.SDCard(spi, cs, baudrate=25000000)
vfs = storage.VfsFat(sdcard)
storage.mount(vfs, "/sd")
print("SD card is {} MiB".format(sdcard.count() * 512 // (1024 * 1024)))
