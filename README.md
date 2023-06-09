# BlissIO's parabola install script

## The real freedom

remember to use this command to run the script

- chmod +x parabola-install.sh

then run

+ ./parabola-install.sh

## Disclaimer

This script is provided as-is, without any warranty or guarantee. Use it at your own risk. It is recommended to review and understand the script before running it on your system.

## Features
This script automates the installation process of Arch Linux using a simple command-line interface. It provides the following features:

1. Checks if the system uses UEFI or BIOS for boot.
2. Updates the repositories and keyrings.
3. Allows the user to choose a keyboard layout from the available options.
4. Guides the user through automatic or manual partitioning of the selected drive.
5. Generates the fstab file.
6. Sets up locales and timezone.
7. Prompts the user for hostname, root password, and a new user.
8. Installs the GRUB bootloader for BIOS or the EFISTUB for UEFI systems.
9. Configures sudo access for the new user.
10. Optionally installs and configures a desktop environment (XFCE, GNOME, KDE) or NetworkManager.
11. Only uses Openrc as its PID1

## Requirements

- An internet connection is required during the installation process.
- Make sure the script is run on a prabola official ISO.
## as always thank you for choosing your freedom
