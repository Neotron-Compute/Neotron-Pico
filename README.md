# Neotron Pico

> A Neotron system powered by the Raspberry Pi Pico, in a micro-ATX form-factor.

The Neotron Pico is based around the idea of the [Neotron-32](https://github.com/neotron-compute/Neotron-32-Hardware), but using a low-cost Raspberry Pi Pico instead of a Texas Instuments Tiva-C Launchpad. It also stretches out to full micro-ATX size, and adds more expansion slots so that you can easily design and add your own peripherals.

![3D PCB View](./neotron-pico.jpg)

## Design

The Raspberry Pi Pico is the core of the Neotron Pico. It uses PIO statemachines to generate 12-bit Super VGA video, and digital 16 bit 48 kHz stereo audio. It also has both I²C and SPI buses. SPI chipselects and IRQs are handled by an SPI-to-GPIO expander. This provides eight chip-selects and eight IRQs, to support up to eight expansion slots or peripherals. The eight chip-selects are gated with a tri-state bus transceiver, allowing the Pico to talk to either the I/O exander, or the selected expansion slot. The board has an SD Card fitted in the 'Slot 1' position, and the Board Management Controller in the 'Slot 0' position, leaving 'Slot 2' through to 'Slot 7' available for expansion. Each expansion slot has both I²C and SPI, along with unique chip-select and IRQ signals.

## Software

The Neotron Pico is designed to run the Neotron OS - a CP/M or MS-DOS alike OS written in Rust. But, being open-hardware, you can program your Neotron Pico to do pretty much anything.

## Specs

* Dual Cortex-M0+
  * One dedicated for video/audio
  * One available for OS/Application use
* 264 KiB SRAM
* 2 MiB Boot ROM
* SD Card slot for storage
* 8V to 28V DC input
* SPI and I²C based expansion bus
  * Four externally accessible expansion slots
  * Two internally accessible expansion slots
* Dual PS/2 ports for Keyboard + Mouse
* 16-bit 48 kHz stereo audio headphone out, line out, line in, and microphone in
* 12-bit (4096 colour) VGA video output
  * Capable of 40x25, 80x25 and 80x50 text modes
  * Capable of 640x480 @ 60 Hz 16-colour and 320x240 @ 60 Hz 256-colour graphics modes
* Designed to run the Neotron OS
* Open Source Hardware
* Designed for hand assembly

## Components in detail

### Processor

The main processor module is the Raspberry Pi Pico, which features:

* A Raspberry Pi Silicon RP2040 SoC
  * Dual-core Cortex-M0+ @ 133 MHz
  * 264 KiB internal SRAM
  * No internal Flash
  * USB 1.1
  * SPI, UART, I²C and _Programmable I/O_ peripherals
* 26 GPIO pins
* 2 MiB QSPI Flash
* On-board LED
* On-board 5V to 3.3V regulator
* USB 2.0 Full-speed OTG micro-AB port
* 4.00 USD / 3.60 GBP retail price

The limited I/O on the Pico (we are using half the available pins just for the video output) is supplemented using a Microchip MCP23S17 SPI to GPIO expander, and an octal buffer. See the [I/O Expanders](#io-expanders) section for more details.

| Pin  | Name | Signal         | Function                                           |
| :--- | :--- | :------------- | :------------------------------------------------- |
| 01   | GP0  | VGA_HSYNC      | VGA Horizontal Sync (31.5 kHz)                     |
| 02   | GP1  | VGA_VSYNC      | VGA Vertical Sync (60 Hz)                          |
| 04   | GP2  | VGA_RED0       | Digital VGA signal, Red channel LSB                |
| 05   | GP3  | VGA_RED1       | Digital VGA signal, Red channel                    |
| 06   | GP4  | VGA_RED2       | Digital VGA signal, Red channel                    |
| 07   | GP5  | VGA_RED3       | Digital VGA signal, Red channel MSB                |
| 09   | GP6  | VGA_GREEN0     | Digital VGA signal, Green channel LSB              |
| 10   | GP7  | VGA_GREEN1     | Digital VGA signal, Green channel                  |
| 11   | GP8  | VGA_GREEN2     | Digital VGA signal, Green channel                  |
| 12   | GP9  | VGA_GREEN3     | Digital VGA signal, Green channel MSB              |
| 14   | GP10 | VGA_BLUE0      | Digital VGA signal, Blue channel LSB               |
| 15   | GP11 | VGA_BLUE1      | Digital VGA signal, Blue channel                   |
| 16   | GP12 | VGA_BLUE2      | Digital VGA signal, Blue channel                   |
| 17   | GP13 | VGA_BLUE3      | Digital VGA signal, Blue channel MSB               |
| 19   | GP14 | I2C_SDA        | I²C Data                                           |
| 20   | GP15 | I2C_SCL        | I²C Clock                                          |
| 21   | GP16 | SPI_CIPO       | SPI Data In                                        |
| 22   | GP17 | SPI_CS_nIOCS   | Low selects MCP23S17, High selects Expansion Slots |
| 24   | GP18 | SPI_CLK        | SPI Clock                                          |
| 25   | GP19 | SPI_COPI       | SPI Data Out                                       |
| 26   | GP20 | nIRQn          | Interrupt Request Input from MCP23S17              |
| 27   | GP21 | nOUTPUT_EN     | Enable buffered CS outputs from MCP23S17           |
| 29   | GP22 | I2S_DAC_DATA   | Digital Audio Output                               |
| 31   | GP26 | I2S_ADC_DATA   | Digital Audio Input                                |
| 32   | GP27 | I2S_LR_CLOCK   | Digital Audio Sync (96kHz)                         |
| 34   | GP28 | I2S_BIT_CLOCK  | Digital Audio Bit Clock (1.536MHz)                 |

### Super VGA output

The Raspberry Pi Silicon RP2040 generates 12-bit VGA video at a range of standard resolutions (including 640x480 @ 60 Hz).

* 15-pin D-Sub VGA interface
* 12-bit (4-4-4) RGB R2R DAC
* 3peak TPF133A or Texas Instruments THS7316 RGB video buffer
   * 36 MHz bandwidth - 1024x768@60Hz maximum
   * 6dB gain
   * Drives 75 ohm standard VGA interface
   * SOIC-8 package (1.27mm pitch)
* Texas Instruments TPD7S019 Sync/DDC level shifter and RGB EMC filter
   * SSOP-16 package (0.635mm pitch)

The design could easily be adapted to remove the TPF133A/THS7316 video buffer and the TPD7S019 level shifter/filter, and instead use the [1BitSquared DVI PMOD](https://1bitsquared.com/collections/fpga/products/pmod-digital-video-interface) board if you prefer a DVI output (using an HDMI connector).

### Audio Codec

The audio subsystem offers 16-bit 48 kHz stereo audio in and out through a classic blue/green/pink triple 3.5mm TRS jack. Input and Output volume can be software controlled.

* Texas Instruments TLV320AIC23B
  * I²S + I²C interface
  * Amplified 32mW headphone output and line out
  * Microphone in and line in
  * TSSOP-28 package (0.635mm pitch)
* Triple 3.5mm TRS jack (Kycon STX-4335-5BGP-S1)
  * Headphone Out (green)
  * Line In (blue)
  * Microphone In (pink)
* AC'97 Pin Header for ATX cases with Audio Jacks
  * Headphone Out
  * Microphone In
* Extra line-level output pin header (e.g. for additional RCA audio jacks - operates in addition to 3.5mm headphone jack output)
* Internal line-level input pin header (e.g. for CD-ROM audio - disabled when 3.5mm line-in jack in-use)

### Board Management Controller

Power-on Reset sequencing, soft shutdown, voltage monitoring and PS/2 interfacing is handled by a separate STM32F0 SoC.

* ST Micro STM32F0 (STM32F031K6T6) microcontroller
  * 32-bit Arm Cortex-M0+ Core
  * 3.3V I/O (5V tolerant)
  * 32 KiB Flash
  * 4 KiB SRAM
  * LQFP-32 package (0.8mm pitch)
* Controls two PS/2 ports
* Monitors 5V and 3.3V rails
* Controls system reset, soft-on and soft-off for main CPU
   * Can turn the main 5V regulator on and off
   * Runs from 3.3V stand-by regulator
* SPI interface (with dedicated IRQ line) with main CPU
* Secondary I²C bus which can be controlled over SPI

| Pin  | Name | Signal     | Function                                     |
| :--- | :--- | :--------- | :------------------------------------------- |
| 02   | PF0  | BUTTON_nPWR| Power Button Input (active low)              |
| 03   | PF1  | HOST_nRST  | Reset Output to reset the rest of the system |
| 06   | PA0  | MON_3V3    | 3.3V rail monitor Input (1.65V nominal)      |
| 07   | PA1  | MON_5V     | 5.0V rail monitor Input (1.65V nominal)      |
| 08   | PA2  | LED0       | PWM output for first Status LED              |
| 09   | PA3  | LED1       | PWM output for second Status LED             |
| 10   | PA4  | SPI1_nCS   | SPI Chip Select Input (active low)           |
| 11   | PA5  | SPI1_SCK   | SPI Clock Input                              |
| 12   | PA6  | SPI1_CIPO  | SPI Data Output                              |
| 13   | PA7  | SPI1_COPI  | SPI Data Input                               |
| 14   | PB0  | BUTTON_nRST| Reset Button Input (active low)              |
| 15   | PB1  | DC_ON      | PSU Enable Output                            |
| 18   | PA8  | IRQ_nHOST  | Interrupt Output to the Host (active low)    |
| 19   | PA9  | I2C1_SCL   | I²C Clock                                    |
| 20   | PA10 | I2C1_SDA   | I²C Data                                     |
| 21   | PA11 | USART1_CTS | UART Clear-to-Send Output                    |
| 22   | PA12 | USART1_RTS | UART Ready-to-Receive Input                  |
| 23   | PA13 | SWDIO      | SWD Progamming Data Input                    |
| 24   | PA14 | SWCLK      | SWD Programming Clock Input                  |
| 25   | PA15 | PS2_CLK0   | Keyboard Clock Input                         |
| 26   | PB3  | PS2_CLK1   | Mouse Clock Input                            |
| 27   | PB4  | PS2_DAT0   | Keyboard Data Input                          |
| 28   | PB5  | PS2_DAT1   | Mouse Data Input                             |
| 29   | PB6  | USART1_TX  | UART Transmit Output                         |
| 30   | PB7  | USART1_RX  | UART Receive Input                           |

Note that in the above table, the UART signals are wired as _Data Terminal Equipment (DTE)_.

This design should also be pin-compatible with the following SoCs (although the software may need recompiling):

* STM32F042K4Tx
* STM32F042K6Tx
* STM32L071KBTx
* STM32L071KZTx
* STM32L072KZTx
* STM32L081KZTx
* STM32L082KZTx

Note that not all STM32 pins are 5V-tolerant, and the PS/2 protocol is a 5V open-collector system, so ensure that whichever part you pick has 5V-tolerant pins (marked `FT` or `FTt` in the datasheet) for the PS/2 signals. All of the parts above _should_ be OK, but they haven't been tested. Let us know if you try one!

### PS/2 Keyboard and Mouse

* Kycon two-port stacked 6-pin DIN sockets (Kycon KMDGX-6S/6S-S4N)
* Controlled via Board Management Controller

### Power Supply

* Unregulated 12V (8V to 28V) input fused with a PTC at 2A
* 3A 5.0V main regulator (DC-DC switch-mode regulator module)
  * Morsun K7805-3AR3
* 30mA 3.3V stand-by regulator (a micropower linear regulator)
* 1A 3.3V regulator (a high-power 1117 type linear regulator)
* Controlled by the Board Management Controller

### I/O Expanders

Because we used so many pins on the Pico for Audio and Video, we don't have enough pins to use for _Chip Select_ lines. Each device we wish to communicate with on the SPI bus must have a unique chip select line and so have limited lines means we could only have a limited number of SPI devices.

However, in this design, we cheat and use a Microchip MCP23S17 I/O expander. This is an SPI peripheral with 16 GPIO pins that can be controlled by sending it commands over SPI. It also has an IRQ output which be programmed to fire when the input pins match a certain state.

The problem would come when the Pico has finished talking to our select SPI device - how does it tell the MCP23S17 to release the current chip select, without the SPI bus traffic also going to the currently selected expansion slot? We resolve this by using a simple 8-bit buffer with an enable pin. This allows the Pico to disconnect all of the chip select signals at once, regardless of the output of the MCP23S17. Once this is disabled, we know we are talking to only the MCP23S17 and the Pico can command it to select the next chip select of interest to us.

Interrupts are also processed through the MCP23S17. We configure the device to provide an IRQ (edge, active low) whenever any of the eight IRQ inputs are active (programmable for edge or level, active high/rising or low/falling). When the Pico receives an IRQ from the MCP23S17, it must do a read of the pins (using SPI) to find out which device actually raised the interrupt. This model is similar to that used in the IBM PC - where the Intel 8088 must talk to an Intel 8259A programmable interrupt controller over the ISA bus to find out which interrupt was raised - except that in our case, our CPU is very fast and our bus is pretty slow, so our interrupt latency isn't very good. Worse, if there is a big SPI transaction happening (such as transferring a 512 byte block from an SD card) when an interrupt fires, the Pico will have to wait for that to complete before it can talk to the MCP23S17 to handle the IRQ. That or it could just drop the SPI transaction mid-way through and re-try it later (if your expansion device can tolerate such rudeness).

```
+------+                                  +-----+
|      |----------OUTPUT_EN-------------->|     |
|      |                                  |     |
|      |           +----------+           |     |
|      |           |          |           |     |
|      |           |          |----CS0--->|     |----CS0----------------------------------+
|      |           |          |           |     |                                         |
|      |           |          |----CS1--->|  B  |----CS1------------------------------+   |
|      |           |          |           |  U  |                                     |   |
|      |           |          |----CS2--->|  F  |----CS2--------------------------+   |   |
|      |           |          |           |  F  |                                 |   |   |
|      |           |          |----CS3--->|  E  |----CS3----------------------+   |   |   |
|      |           |          |           |  R  |                             |   |   |   |
|      |           |          |----CS4--->|     |----CS4------------------+   |   |   |   |
|      |           |          |           |     |                         |   |   |   |   |
|      |           |          |----CS5--->|     |----CS5--------------+   |   |   |   |   |
|      |           |          |           |     |                     |   |   |   |   |   |
|      |           |          |----CS6--->|     |----CS6----------+   |   |   |   |   |   |
| Pico |           | MCP23S17 |           |     |                 |   |   |   |   |   |   |
|      |           |          |----CS7--->|     |----CS7------+   |   |   |   |   |   |   |
|      |           |          |           +-----+             v   v   v   v   v   v   v   v
|      |           |          |                             +---+---+---+---+---+---+---+---+
|      |----CS---->|          |                             | S | S | S | S | S | S | S | S |
|      |<---IRQ----|          |                             | l | l | l | l | l | l | l | l |
|      |<===SPI===>|          |<============SPI============>| o | o | o | o | o | o | o | o |
|      |           |          |                             | t | t | t | t | t | t | t | t |
|      |           |          |                             |   |   |   |   |   |   |   |   |
|      |           |          |                             | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|      |           |          |                             +---+---+---+---+---+---+---+---+
|      |           |          |<---IRQ7-----------------------+   |   |   |   |   |   |   |
|      |           |          |                                   |   |   |   |   |   |   |
|      |           |          |<---IRQ6---------------------------+   |   |   |   |   |   |
|      |           |          |                                       |   |   |   |   |   |
|      |           |          |<---IRQ5-------------------------------+   |   |   |   |   |
|      |           |          |                                           |   |   |   |   |
|      |           |          |<---IRQ4-----------------------------------+   |   |   |   |
|      |           |          |                                               |   |   |   |
|      |           |          |<---IRQ3---------------------------------------+   |   |   |
|      |           |          |                                                   |   |   |
|      |           |          |<---IRQ2-------------------------------------------+   |   |
|      |           |          |                                                       |   |
|      |           |          |<---IRQ1-----------------------------------------------+   |
|      |           |          |                                                           |
|      |           |          |<---IRQ0---------------------------------------------------+
+------+           +----------+
```

## Expansion

The seven expansion sockets allow you to add on I²C or SPI based devices at a later date. Each provides a single chip-select and a single IRQ line - the motherboard design should ensure each socket gets a unique signal for each of these. Each expansion device should also contain a AT24C256 or similar EEPROM device. To allow these EEPROM devices to be scanned, each slot also contains three `EEPROM_ADDRESS` pins, tied to Vcc or GND in a unique combination. These should be connected through to the EEPROM address lines on your AT24C256, thus ensuring that each expansion card has its EEPROM at a unique address - 0x50 on Slot 0 through to a maximum possible 0x57 for Slot 7. Where your board has on-board devices, you should fit an AT24C256 EEPROM for each device so that the on-board devices can be discovered, exactly as if they were on an expansion card.

The expansion slot is a simple 2x10 header. We suggest the use of a TE card-edge connector, but you could equally use two 1x10 pin-headers if desired.

The expansion connector pinout is:

```
     SPI_COPI   1    2   GND
     SPI_CIPO   3    4   GND
      SPI_CLK   5    6   GND
      ~SPI_CS   7    8   ~IRQ
      I2C_SDA   9   10   I2C_SCL
 EEPROM_ADDR0   11  12   EEPROM_ADDR1
 EEPROM_ADDR2   13  14   ~RESET
           5V   15  16   5V
          3V3   17  18   3V3
          GND   19  20   GND
```

Four expansion slots line up with the ATX case expansion brackets, allowing you to use cards with external connectors. Note that these are aligned the "PCI way around" with components facing away from the board's I/O area, rather than the "ISA way around" which would have the components facing the I/O area. A further three of the expansion slots are available for internal use only.

### I²C Bus

All I²C device address given below are 7-bit values. The first byte in a message is the _control byte_; this is comprised of the device address in the top seven bits, and an extra bit at the bottom to indicate read (1) or write (0).

The memory addresses given are 8-bit values used to access the contents of an I²C device, and are usually supplied as the second byte in a message.

* Device Address 0x1A - TLV320AIC23
  * Memory Address 0x00 - Left line input channel volume control
  * Memory Address 0x01 - Right line input channel volume control
  * Memory Address 0x02 - Left channel headphone volume control
  * Memory Address 0x03 - Right channel headphone volume control
  * Memory Address 0x04 - Analog audio path control
  * Memory Address 0x05 - Digital audio path control
  * Memory Address 0x06 - Power down control
  * Memory Address 0x07 - Digital audio interface format
  * Memory Address 0x08 - Sample rate control
  * Memory Address 0x09 - Digital interface activation
  * Memory Address 0x0F - Reset register
* Device Address 0x50 - VGA Monitor (DDC)
  * Memory Addresses 0x00..0xFF - Monitor Specifications in [EDID format](https://en.wikipedia.org/wiki/Extended_Display_Identification_Data)
* Device Address 0x51 - Slot 1 ID EEPROM
  * Memory Addresses 0x00..0xFF - Expansion Card Specification in NEID (Neotron Expansion ID) format
* Device Address 0x52 - Slot 2 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x53 - Slot 3 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x54 - Slot 4 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x55 - Slot 5 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x56 - Slot 6 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x57 - Slot 7 ID EEPROM
  * Memory Addresses as per Slot 1
* Device Address 0x6F - Real-time Clock
  * Memory Addresses 0x00..0x1F - Clock Configuration
  * Memory Addresses 0x20..0x5F - Battery-backed SRAM

### SPI Chip Selects

### Interrupt Assignments

## Expansion Ideas

Why not design and build your own expansion card? You could try designing:

* A dual Atari/SEGA 9-pin Joypad Interface
* A Mikro Electronika Click adaptor, allow many of the range of [Click boards](https://www.mikroe.com/click) to be fitted
* A Wi-Fi/Bluetooth card, using an Espressif ESP32
* A second processor card - perhaps with a RISC-V microcontroller, or classic Zilog Z80
* An OPL2 or OPL3 based FM synthesiser card
* An ISA adaptor card (taking an ISA card at right-angles, i.e. parallel to the base board) - a simple microcontroller should be able to bit-bang the ISA bus at 8 MHz and offer an SPI peripheral interface to the Neotron Expansion Slot
* An IDE interface card, allowing 40-pin IDE Hard Disk Drives and CD-ROM drives to be used - this will be quite similar to an ISA bus adaptor
* A floppy drive controller card - either using an eSPI Super I/O chip, or connecting a legacy ISA bus floppy controller as per the ISA adaptor
* A video card for a second monitor output, perhaps based on the CPLD used in the [VGAtonic](https://hackaday.io/project/6309-vga-graphics-over-spi-and-serial-vgatonic)

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a list of detailed changes.

## Git Setup

We recommend you have the following Git config set:

```
$ git config --global filter.kicad_project.clean "sed -E 's/^update=.*$/update=Date/'"
$ git config --global filter.kicad_project.smudge cat
$ git config --global filter.kicad_sch.clean "sed -E 's/#(PWR|FLG)[0-9]+/#\1?/'"
$ git config --global filter.kicad_sch.smudge cat
```

See https://jnavila.github.io/plotkicadsch/ for details.

## Licence

These documents, schematics and PCB designs are Copyright (c) The Neotron Developers.

[![CC BY-SA 4.0](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

Please note that the models provided in the [Kicad/Models](./Kicad/Models) directory are from various manufacturers. Terms and conditions for the use of the models are as specified by the original manufacturer/author.

## Contribution Agreement

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be licensed as above, without any additional terms or conditions.

## Changelog

The Change Log for the project can be found in [./CHANGELOG.md](./CHANGELOG.md).

## Datasheets and References

* Raspberry Pi Pico
  * Datasheet: <https://datasheets.raspberrypi.org/pico/pico-datasheet.pdf>
* Raspberry Pi Silicon RP2040
  * Datasheet: <https://datasheets.raspberrypi.org/rp2040/rp2040-datasheet.pdf>
  * Hardware Design Guide: <https://datasheets.raspberrypi.org/rp2040/hardware-design-with-rp2040.pdf>
* ST Microelectronics STM32F031K6T6
  * Datasheet: <https://www.st.com/resource/en/datasheet/stm32f031k6.pdf>
* Morsun K7805-3AR3
  * Datasheet: <https://www.mornsunpower.de/html/pdf/K7805-3AR3.html>
* Texas Instruments TLV320AIC23B
  * Datasheet: <https://www.ti.com/lit/ds/symlink/tlv320aic23b.pdf>
* Texas Instruments THS7316
  * Datasheet: <https://www.ti.com/lit/ds/symlink/ths7316.pdf>
* Texas Instruments TPD7S019
  * Datasheet: <https://www.ti.com/lit/ds/symlink/tpd7s019.pdf>
* Microchip 24LC256 EEPROM
  * Info Page: <https://www.microchip.com/wwwproducts/en/24LC256>
* Microchip MCP7940N Real-Time Clock
  * Info Page: <https://www.microchip.com/wwwproducts/en/MCP7940N>
