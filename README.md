# Neotron Pico

> A Neotron system powered by the Raspberry Pi Pico, in a micro-ATX form-factor.

The Neotron Pico is based around the idea of the [Neotron-32](https://github.com/neotron-compute/Neotron-32-Hardware), but using a low-cost Raspberry Pi Pico instead of a Texas Instuments Tiva-C Launchpad. It also stretches out to full micro-ATX size, and adds more expansion slots so that you can easily design and add your own peripherals.

## Design

The Raspberry Pi Pico is the core of the Neotron Pico. It uses PIO statemachines to generate 12-bit Super VGA video, and digital 16 bit 48 kHz stereo audio. It also has both I²C and SPI buses. SPI chipselects and IRQs are handled by an SPI-to-GPIO expander. This provides eight chip-selects and eight IRQs, to support up to eight expansion slots or peripherals. The eight chip-selects are gated with a tri-state bus transceiver, allowing the Pico to talk to either the I/O exander, or the selected expansion slot. The board has an SD fitted in the 'Slot 7' position, leaving Slot 0 through to Slot 6 available for expansion. Each expansion slot has I²C and SPI with unique chip-select and IRQ signals. A separate Board Mangement Controller also sits on the I²C bus handling PS/2 devices, and controlling power and reset. The BMC uses IRQ 7.

## Software

The Neotron Pico is designed to run the Neotron OS - a CP/M or MS-DOS alike OS written in Rust. But, being open-hardware, you can program your Neotron Pico to do pretty much anything.

## Components

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

The limited I/O on the Pico (we are using half the available pins just for the video output) is supplemented using a Microchip MCP23S17 SPI to GPIO expander, an octal buffer. The buffer allows the Pico to send its SPI bus data to either the MCP23S17 (to set  a specific Chip Select line), or the rest of the system. Without the buffer, it would be impossible to command the MCP23S17 to disable a chip-select line once it had been set, without the traffic also going to the selected expansion slot!

| Pin  | Name | Signal         | Function                                           |
| :--- | :--- | :------------- | :------------------------------------------------- |
| xx   | GPx  | VGA_RED0       | Digital VGA signal, Red channel LSB                |
| xx   | GPx  | VGA_RED1       | Digital VGA signal, Red channel                    |
| xx   | GPx  | VGA_RED2       | Digital VGA signal, Red channel                    |
| xx   | GPx  | VGA_RED3       | Digital VGA signal, Red channel MSB                |
| xx   | GPx  | VGA_GREEN0     | Digital VGA signal, Green channel LSB              |
| xx   | GPx  | VGA_GREEN1     | Digital VGA signal, Green channel                  |
| xx   | GPx  | VGA_GREEN2     | Digital VGA signal, Green channel                  |
| xx   | GPx  | VGA_GREEN3     | Digital VGA signal, Green channel MSB              |
| xx   | GPx  | VGA_BLUE0      | Digital VGA signal, Blue channel LSB               |
| xx   | GPx  | VGA_BLUE1      | Digital VGA signal, Blue channel                   |
| xx   | GPx  | VGA_BLUE2      | Digital VGA signal, Blue channel                   |
| xx   | GPx  | VGA_BLUE3      | Digital VGA signal, Blue channel MSB               |
| xx   | GPx  | VGA_HSYNC      | VGA Horizontal Sync (31.5 kHz)                     |
| xx   | GPx  | VGA_VSYNC      | VGA Vertical Sync (60 Hz)                          |
| xx   | GPx  | I2C_SDA        | I²C Data                                           |
| xx   | GPx  | I2C_SCL        | I²C Clock                                          |
| xx   | GPx  | SPI_CLK        | SPI Clock                                          |
| xx   | GPx  | SPI_CIPO       | SPI Data In                                        |
| xx   | GPx  | SPI_COPI       | SPI Data Out                                       |
| xx   | GPx  | SPI_CS_nIOCS   | Low selects MCP23S17, High selects Expansion Slots |
| xx   | GPx  | nIRQn          | Interrupt Request Input from MCP23S17              |
| xx   | GPx  | I2S_DAC_DATA   | Digital Audio Output                               |
| xx   | GPx  | I2S_ADC_DATA   | Digital Audio Input                                |
| xx   | GPx  | I2S_BIT_CLOCK  | Digital Audio Bit Clock (1.536MHz)                 |
| xx   | GPx  | I2S_LR_CLOCK   | Digital Audio Sync (96kHz)                         |
| xx   | GPx  | I2S_MAIN_CLOCK | Digital Audio Master Clock (12.288MHz)             |

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
* Can the main 5V regulator on and off
* Runs from 3.3V stand-by regulator
* I²C interface (with dedicated IRQ line) with main CPU

| Pin  | Name | Signal        | Function                                                |
| :--- | :--- | :------------ | :------------------------------------------------------ |
| 14   | PB0  | -             | Spare                                                   |
| 15   | PB1  | -             | Spare                                                   |
| 26   | PB3  | -             | Spare                                                   |
| 27   | PB4  | PS2_CLK1      | Mouse Clock Input                                       |
| 28   | PB5  | PS2_DAT1      | Mouse Data Input                                        |
| 29   | PB6  | I2C_SCL       | I²C Clock                                               |
| 30   | PB7  | I2C_SDA       | I²C Data                                                |
| 2    | PF0  | -             | Spare                                                   |
| 3    | PF1  | -             | Spare                                                   |
| 6    | PA0  | MON_3V3       | 3.3V rail monitor Input (1.65V nominal)                 |
| 7    | PA1  | MON_5V        | 5.0V rail monitor Input (1.65V nominal)                 |
| 8    | PA2  | UART_TX       | UART Data Output                                        |
| 9    | PA3  | UART_RX       | UART Data Input                                         |
| 10   | PA4  | /BUTTON_PWR   | Power Button Input                                      |
| 11   | PA5  | STATUS_LED    | Status LED Output                                       |
| 12   | PA6  | /BUTTON_RST   | Reset Button Input                                      |
| 13   | PA7  | -             | Spare                                                   |
| 18   | PA8  | /IRQ          | Interrupt Output                                        |
| 19   | PA9  | PS2_DAT0      | Keyboard Data Input                                     |
| 20   | PA10 | PS2_CLK0      | Keyboard Clock Input                                    |
| 21   | PA11 | /RESET        | System Reset Output                                     |
| 22   | PA12 | DC_ON         | PSU Enable Output                                       |
| 23   | PA13 | SWDIO         | SWD Progamming Data Input                               |
| 24   | PA14 | SWCLK_BOOT_TX | SWD Programming Clock Input OR Bootloader UART RX Input |
| 25   | PA15 | BOOT_RX       | Bootloader UART TX Output                               |

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

## Expansion

The seven expansion sockets allow you to add on I²C or SPI based devices at a later date. Each provides a single chip-select and a single IRQ line - the motherboard design should ensure each socket gets a unique signal for each of these. Each expansion device should also contain a AT24C256 or similar EEPROM device. To allow these EEPROM devices to be scanned, each slot also contains three `EEPROM_ADDRESS` pins, tied to Vcc or GND in a unique combination. These should be connected through to the EEPROM address lines on your AT24C256, thus ensuring that each expansion card has its EEPROM at a unique address - 0x50 on Slot 0 through to a maximum possible 0x57 for Slot 7. Where your board has on-board devices, you should fit an AT24C256 EEPROM for each device so that the on-board devices can be discovered, exactly as if they were on an expansion card.

The expansion slot is a simple 2x10 header. We suggest the use of a TE card-edge connector, but you could equally use two 1x10 pin-headers if desired.

The pin functions are:

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

Four expansion slots line up with the ATX case expansion brackets, allowing you to use cards with external connectors. Three of the expansion slots are internal use only.

## Expansion Ideas

Why not design and build your own expansion card? You could try designing:

* A dual Atari/SEGA 9-pin Joypad Interface
* A Mikro Eletronika Click adaptor, allow many of the range of [Click board](https://www.mikroe.com/click) to be fitted
* A Wi-Fi/Bluetooth card, using an Espressif ESP32
* A second processor card - perhaps with a RISC-V microcontroller, or classic Zilog Z80
* An OPL2 or OPL3 based FM synthesiser card
* An ISA adaptor card (taking an ISA card at right-angles, i.e. parallel to the base board) - a simple microcontroller should be able to bit-bang the ISA bus at 8 MHz and offer an SPI peripheral interface to the Neotron Expansion Slot
* An IDE interface card, allowing 40-pin IDE Hard Disk Drives and CD-ROM drives to be used - this will be quite similar to an ISA bus adaptor
* A floppy drive controller card - either using an eSPI Super I/O chip, or connecting a legacy ISA bus floppy controller as per the ISA adaptor
* A video card for a second monitor output, perhaps based on the CPLD used in the [VGAtonic](https://hackaday.io/project/6309-vga-graphics-over-spi-and-serial-vgatonic)

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for a list of detailed changes.

## Licence

These documents, schematics and PCB designs are Copyright (c) The Neotron Developers.

[![CC BY-SA 4.0](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/).

## Contribution Agreement

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as defined in the Apache-2.0 license, shall be licensed as above, without any additional terms or conditions.

## Datasheets and References

* Raspberry Pi Pico
* Raspberry Pi Silicon RP2040
* ST Microelectronics STM32F031K6T6
* Morsun K7805-3AR3
* Texas Instruments TLV320AIC23B
* Texas Instruments THS7316
* Texas Instruments TPD7S019