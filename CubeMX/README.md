# CubeMX

## What is CubeMX?

The Neotron Pico uses an STM32F031 as a Board Management Controller. ST's CubeMX software allows you to configure ST Micro devices, such as our STM32F031.

## What is in this folder?

This folder contains a configuration file for ST's CubeMX Software, for the BMC MCU. This allows us to confirm that the pinout specified in the schematic can be supported by the MCU's internal pin-muxing architecture, as only certain peripherals are available on each pin.

## Do we autogen code with CubeMX?

We do not currently use the code generation feature. The firmware for the Neotron Pico's BMC can be found at https://github.com/Neotron-Compute/Neotron-BMC.

## Where can I get CubeMX?

You can download it from https://www.st.com/en/development-tools/stm32cubemx.html.

