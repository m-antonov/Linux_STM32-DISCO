# Linux on the STM32 Discovery boards with Buildroot
The project is a set of patches and configuration files to build bootloader and Linux based system image with a minimal root file system for the following collections of STM32 Discovery boards:
- [32F429IDISCOVERY Discovery kit](https://www.st.com/en/evaluation-tools/32f429idiscovery.html) [PENDING]
- [32F746GDISCOVERY Discovery kit](https://www.st.com/en/evaluation-tools/32f746gdiscovery.html) [READY]
- [32F769IDISCOVERY Discovery kit](https://www.st.com/en/evaluation-tools/32f769idiscovery.html) [PENDING]
- [STM32MP157A-DK1 / STM32MP157C-DK2 Discovery kits](https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html) [PENDING]

The following versions of tools are using in the project:
- Buildroot v2020.05
- U-Boot v2018.07
- Linux kernel v5.4.46

# Build
`$ make bootstrap` - downloading source code and copying configuration of a development board
`$ make build` - compiling bootloader and Linux based system image with a minimal root file system
`$ make tftp` - copying device tree binary and kernel image to the TFTP destination folder
`$ make flash_bootloader` - flashing SPL and U-Boot to a development board via OpenOCD with ST-LINK
`$ make clean` - clearing temporary folders for downloading and compiling source code

# Run
System image and device tree binary are loading over a network with the blue user button held down during development board startup. The default IP addresses of TFTP server and development kit are `10.0.222.9` and `10.0.222.100` respectively. To change the IP address edit the [U-Boot environment](https://github.com/lompal/Linux_STM32-DISCO/blob/master/patch/u-boot_env.patch) patch.
