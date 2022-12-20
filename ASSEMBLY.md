# Assembly Instructions

This document explains how to assemble a Neotron Pico kit. It is based around the v1.1.0 Kit, but other versions may be similar.

Assembling a Neotron Pico Kit involves the following components:

* A PCB
* Some surface-mount components
* Some through-hole components
* A power supply, for testing
* An Arm Serial Wire Debug (SWD) programmer (a Raspberry Pi Pico can be used)
* A micro-ATX case, some stand-offs or some rubber feet.

You may have received a kit with some (or all) of the surface mount parts fitted in the factory. If so, you can skip any parts that are already on your board.

## Getting to know the board

The main processor on your Neotron Pico is the Raspberry Pi Pico (hence the name). This lives at the 'top' of the board, with the other external connectors - you can clearly see the 43 large golden pads. To the right of the Raspberry Pi Pico is the 12V DC power input jack, and the PS/2 keyboard and mouse ports. To the left is the VGA circuitry and video output connector, SD Card and Audio input/output jacks. To the far left are four expansion slots for adding upgrades to your Neotron Pico. The Board Management Controller is the is just below-right from the Raspberry Pi Pico and the Power Supply runs along the right-hand edge of the board. In the middle is the IO controller chip and below that the Real Time Clock and its CR2023 coin-cell backup battery. Along the bottom edge are the PC case connectors, for the power button, power LED, hard drive LED and so on. Don't worry if you don't have a PC case, we've also included LEDs and buttons on-board which you can use instead.

We recommend your Raspberry Pi Pico has header pins, and if so, you should fit matching 2.54mm header sockets to your Neotron Pico. These are usually not included in the kit and should be ordered with your Raspberry Pi Pico. If you don't want to use header pins and sockets, you can solder the Raspberry Pi Pico straight down to your Neotron Pico, soldering each of the castellated edges.

You board has some pins marked "TPxxx". These are test points, and are connected to *GND*. You can solder a U-shaped bent cut-off capacitor leg here to each of these if you like, to give your oscilloscope ground-lead something handy to connect to if you ever need to probe the board. Or you can leave them empty.

## My board has some parts missing!

There are some "Do Not Fit" components on your Neotron Pico, so if you ordered it with surface-mount parts already assembled, do not be alarmed if some pads look empty. These are:

* R404 next to the VGA connector. You could add a 0 ohm resistor here to tie the VGA cable shield to ground if you have issues with video noise.
* JP401, JP402, JP403 and JP404. These are for bypassing the TPD7S019 ESD protection chip (U402) in case you couldn't get hold of one and don't have it fitted.
* C901/902/903/904/905/906. These are for slew-limiting signals on the SPI bus. If you have EMC issues, you can replace the matching R90x 0-ohm resistor with a higher value, and fit a small capacitor to the C90x pads. Consult an EMC engineer for further details.

If any other pads look empty, maybe the PCB assembler didn't have the relevant component in stock. Have a look in the kit - maybe it's been included for you to fit yourself. And do look carefully, as some are quite small. It's probably been stuck to something with sticky tape so it doesn't get lost. In particular, Serial Numbers JP00011 to JP00040 are missing U401 (the RGB video buffer), and it's been taped to the top of the Triple 3.5mm audio jack.

## How to solder

The Neotron Pico kit does assume you can solder at an intermediate level. If you need guidance on soldering (especially any of the smaller surface-mount parts) there are many excellent guides online or on YouTube.

## The Interactive Bill of Materials

The best way to find where to fit the components to your PCB is to use the Interactive Bill of Materials (also known as the IBOM). This is a web-page with a diagram of the PCB and a list of all the components. As you click a component it is highlighted on the PC. Conversely, if you click on the diagram, the relevant component is highlighted in the table. Do ensure you click the *"Sourced"* checkbox when you have determined you have the part in stock, and that you click the *"Placed"* checkbox when the component has been fitted. If your PCB was supplied with some parts already fitted, tick those off now.

The IBOM file can be found by clicking the Releases shortcut available to the right on the GitHub page, or downloading it directly: [IBOM v1.1.0](https://github.com/Neotron-Compute/Neotron-Pico/releases/download/v1.1.0/neotron-pico-v1.1.0-ibom.html). Open the saved file in a browser.

## But what order should I fit things in?

The general rule is to fit the parts with the lowest Z-height first (i.e. the flat ones, that stick out the least). This means if you flip the PCB over to solder on the underside, you won't have a tall component preventing the board from lying flat and causing the component you are currently trying to solder to fall out of its hole. A suggested order is:

* All surface mount components (including U401, which may not have been presoldered in your kit)
    * U401 has a line to the left of the chip which should correspond to the line to the left of the PCB foot print
* Short-circuit JP1201 *or* JP1201
    * If you have a DS1307 short JP1201 to give it 5V
    * If you have an MCP7940, short JP1202 to give it 3.3V
* The SD Card Socket (J1101)
* The 28-pin DIP socket (U301)
* The DC Input jack (J1301)
* The 22uH Inductor (L1301), PTC fuse (F1301) and electrolytic capacitors (C801, C808, C809, C1301, C1302)
* The PSU module (U1301)
* The Raspberry Pi Pico (if you want to solder it straight to the board) (U201)
* Any 2.54mm pin headers and jumpers
    * Don't worry about J906, J907 and J908 - they're just for debugging/testing/probing. It's easier to put an oscilloscope probe directly into a hole.
    * Ensure you leave out pin 8 on the J802 PC case audio connector, as most cases have a blank position on the mating connector to make sure you can't put it in backwards. See *Not using a PCB Case* if you don't actually connect this header to your ATX case, as you'll need to fit some jumpers:

        ```text
             +----+----+----+----+----+
             |  2 |  3 |  6 |  X | 10 |
        Case +----+----+----+----+----+
             |  1 |  4 |  5 |  7 |  9 |
             +----+----+----+----+----+
        ```

* Any 2.54mm pin sockets (e.g. for the Raspberry Pi Pico, if you didn't solder it down directly earlier)
* The Expansion Connectors (J902, J903, J904, J905)
* The VGA Connector (J401)
* The Triple 3.5mm audio connector (U802)
* The PS/2 connector (J1007)

Don't forget to put the MCP23S17 chip (U301) in its socket.

## Programming the BMC

The Board Management Controller (BMC) is responsible for controlling power and reset signals. If it hasn't been programmed, the power button won't work. Also, the power LED won't light up. If you apply 12V DC power and the power LED blinks, then the BMC has been programmed already and you should be OK (unless you want to update the firmware).

1. Get the firmware from <https://github.com/Neotron-Compute/Neotron-BMC/releases>. You want `neotron-bmc-pico`.
    * Or you can clone the source code and build it by following the instructions.
2. Rename the file `neotron-bmc-pico.elf`
3. Ensure you have the Rust Programming Language installed (see <https://www.rust-lang.org>)
4. Install the `probe-run` tool:

    ```console
    $ cargo install probe-run
    ```

    **NOTE**: On Linux you will need to install probe-run's dependencies (libudev and libusb) before probe-run. 
    For Debian based distros, run `sudo apt install -y libusb-1.0-0-dev libudev-dev`
    For Fedora based distros, run `sudo dnf install -y libusbx-devel systemd-devel`
    See https://github.com/knurling-rs/probe-run#installation for the latest dependency information

5. Connect your Arm Serial Wire Debug probe to J1001, the BMC programming header.
    * If you have 12V DC power to the board, the 3.3V pin will be live and should be treated as an output - connect it to the VTref pin of your programmer if it has one.
    * If you do not have 12V DC power to your board (maybe you haven't fitted any of the through-hole parts yet), you can inject 3.3V power here if you are careful. This will reverse-power the 3.3V standby regulator, but it seems to survive (at least for short periods of time).
6. Run `probe-run --chip STM32F030K6Tx ./neotron-bmc-pico` and ensure it completes successfully and prints some log messages from the chip. If there are any errors, investigate.
7. Disconnect the Arm SWD programmer and remove any power from the board.
8. Apply 12V DC power to the board and observe that the Power LED is blinking.
9. Tap the ON/OFF button and observe the Power LED is now on solidly.
10. Check the 5V and 3.3V rails with a multimeter.
11. Hold the ON/OFF button and observe the Power LED returns to blinking.
12. Check the 5V and 3.3V rails - they should fall to 0V.

## Programming the Raspberry Pi Pico

1. Do a `git clone` of the firmware at <https://github.com/Neotron-Compute/Neotron-Pico-BIOS>.
2. Ensure you have the Rust Programming Language installed (see <https://www.rust-lang.org>)
3. Install the `probe-run` tool (if you didn't do it earlier):

    ```console
    $ cargo install probe-run
    ```

4. Connect 12V DC to your board and press the ON/OFF button (if the BMC isn't programmed, do that first).
5. Connect your Arm Serial Wire Debug probe to the SWD pins of the Raspberry Pi Pico.
6. Add the target architecture to Rust installation with `rustup target add thumbv6m-none-eabi`.
7. Run `cargo run --release` and ensure it completes successfully and prints some log messages from the chip. If there are any errors, investigate.
8. Check you have some output on the VGA connector.

The Neotron Pico BIOS usually includes some version of the Neotron OS, but at the time of writing (November 2022) it's at a very very early stage so it may not do much beyond displaying some text.

Time to learn Rust and get hacking on the BIOS and the OS! That's what the Neotron Pico is all about.

## I don't have an Arm SWD Debug Probe

You can make one out of a Raspberry Pi Pico. See <https://github.com/rp-rs/rp2040-project-template/blob/main/debug_probes.md> for more details.

For Linux Mint (and likely most other modern Linux distributions), you will not have sufficient privileges to access the probe without adding a udev rules file.

The following instructions will set up udev to allow access to your probe:

```system
wget https://probe.rs/files/69-probe-rs.rules
sudo mv 69-probe-rs.rules /etc/udev/rules.d/
sudo udevadm control --reload
sudo udevadm trigger
```

You also need to add your user to the plugdev group for these permissions to apply:

```system
sudo usermod -a -G plugdev replace_this_with_your_username
```


## Connecting up a PC Case

You can connect the power and reset buttons of a standard ATX case to the relevant pin headers (J1002 and J1003). You also connect an 8 ohm speaker to J1006, and the Power and HDD LEDs to J1005 and J1004.

If your case has AC'97 audio jacks, you can connect the header to J802. Hopefully you left out pin 8, as directed above, otherwise the cable from your case may not fit. Don't force it!

## Not using a PCB Case

Either fit brass stand-offs to each mounting hole (using an M3 machine screw, and don't over-tighten), or fit some sticky rubber feet to the underside of your PCB. Otherwise your Neotron Pico may scratch your desk, and may be shorted-circuited if you accidentally place the PCB on top of something conductive.

Also, you should fit two jumpers to the J802 header - one across pins 5 and 6 and another across pins 9 and 10. This will allow audio to reach the rear audio jacks, even though you don't have a PC case fitted.

```text
+-----+-----+-----+-----+-----+
|     |     |+---+|     |+---+|
|  2  |  3  || 6 ||  X  ||10 ||
|     |     ||   ||     ||   ||
+-----+-----+|   |+-----+|   |+
|     |     ||   ||     ||   ||
   1  |  4  || 5 ||  7  || 9 ||
|     |     |+---+|     |+---+|
+-  --+-----+-----+-----+-----+
              ^^^         ^^^
```

## Something's not working!

If you paid a commercial company some actual money for your Neotron Pico, in which case ask whoever you bought it from. Don't let businesses selling commercial products fob you off with 'community' support from the volunteers - they're making a profit from our open source work, so they can afford to help you themselves in the first instance.

To chat with the developers and other users, jump in the Matrix Chat and ask nicely. Don't forget, we're all volunteers here, but we like to help people out as much as we can. Just visit <https://matrix.to/#/#neotron:matrix.org> - you can use Element in your browser, so there's nothing to install, but you will need to create an account. If you have some Embedded Rust questions, you could try the `#rust-embedded` and/or the `#rp-rs` Matrix chat rooms.

If you think something's wrong with the design, please do open a Github Issue at <https://github.com/Neotron-Compute/Neotron-Pico/issues>.

