# Changelog

# Unreleased Changes

# None

# [Version v1.1.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v1.1.0)

* Split microphone audio / bias (#132)
* Added more GND vias near power vias
* Minor adjustments to schematic labels
* DNF components now not shown on iBOM
* J901 is a header not a socket
* External LED drive is 5V 20mA
* Moved passives clear away from expansion slot legs
* Updated STEP model
* Added new top-down view to README.
* BMC part as being STM32F030K6T6 (F031 is unavailable)
* Specify THS7316 as default video buffer (TPF133A and DIO2663 should also work)
* Stitching vias for ground planes, and wider traces between vias and pads

# [Version v1.0.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v1.0.0)

* Re-arranged top-sheet
* Two PSU control BJTs are now surface mount
* Support 5V DS1307+ as well as 3.3V MCP7940N Real Time Clock
* Use 200mA Holtek HT7533-1 stand-by regulator
* Swapped MCP23S17 for MCP23S18 (because that's what's available)
* Added internal 12V input header
* Changed inner layers to both be GND
* K7805-3AR3 control pin is protected with a zener (allows higher input voltages)
* HDD LED is driven from I/O mux, not BMC
* Relaid out board
* Replaced 12 MHz Crystal with JLCPCB basic part (#103)
* Replaced SD Card with Amphenol part (#99)
* Redesigned audio paths (#93)
* Replaced decoupling with single 10uF (#92)
* Added PC speaker output (#87)
* Changed K7805-3AR3 to have ceramic output cap (#84)
* Remove all the Octopart CPL references (#83)
* Increased VGA DAC current (#77)
* Replace 74HC245 with 74HC138, plus five LEDS for the now spare pins (#65)
* Added missing I²C pull-ups (#61)
* Change I²S pinout to match Raspberry Pi demo board (#60)
* Pulled CODEC's CS pin (#59)
* Added pull-ups to all SPI CS lines (#58)
* VGA ESD protection chip has bypass pins for when not fitted (#51)
* Case LEDs driven from 12V supply (#46)
* Fixed dead short through PSU Control BJTs (#43)
* Adds 6mm switches for power and reset (#42)
* Added internal 5V/3.3V output header (#41)
* Reverse polarity protection on the input (#40)

# [Version v0.5.2](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.5.2)

* Tweaks to the BOM outputs, including an HTML format BOM
* Revised voltages for each capacitor, specifying the minimum acceptable
   * Most parts still specify a component that is better than the minimum, because of availability or price.

# [Version v0.5.1](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.5.1)

* Moved BOOT0 silkscreen
* Moved labels for BMC SWD and UART ports
* Moved some vias near the BMC to improve the ground pour
* Added version numbers to the release outputs
* Added PNG, SVG and STEP releaseoutputs

# [Version v0.5.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.5.0)

* Sent to JLCPCB to assembly.
   * Note that C901 and C902 part no.s were wrong and were manually fixed before ordering.
* Replaced SIP resistor array for PS/2 ports with four SMD resistors

# [Version v0.4.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.4.0)

* Swap fill on bottom layer to be 3.3V not Ground
* Replace RTC with DIP package due to availability
* Increase size of electrolytic capacitor footprint, to better suit size of common parts
* Replaced VGA connector - in-stock ones have the pins set back from the board edge

# [Version v0.3.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.3.0)

* Adds via stitching around the edge of the board

# [Version v0.2.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/tag/v0.2.0)

* First complete PCB layout

