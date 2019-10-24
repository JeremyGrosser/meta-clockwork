# Yocto BSP for ClockworkPi boards

## Naming

Clockwork Tech is a company that sells the GameShell, a handheld game console
kit. One of the modules in the GameShell kit is a compute board based on the
AllWinner R16, also known as A33, or sun8i in some codebases. Presumably,
Clockwork Tech could release upgraded compute modules for the GameShell in the
future, so we've named this layer "meta-clockwork" to encompass BSPs for all
Linux compatible boards from this company.

Currently, the only board is known as *cpi3*. I have no idea what happened to
cpi1 and cpi2. I assume the Pi in the name is meant to remind you of the
RaspberryPi, a similar and much more popular development board.

## Features

 - Building u-boot and SPL from source, no copying binaries from the clockwork images!
 - Patched mainline Linux 5.2.5 kernel from meta-sunxi, includes Lima drivers
 - Mesa 19.1.6, also with Lima, from Yocto core
 - Broadcom wifi firmware configuration

## Known Issues

 - u-boot LCD flashes on startup, doesn't display anything. Suspect an issue
   with LCD timings or polarity in the u-boot defconfig.
 - DRAM clock can probably be increased, but the current setting is a safe
   default.
 - No HDMI output. Need to combine the -hdmi dts and configure wayland for a
   second output.
 - Boot takes a few seconds due to overly complicated u-boot scripts.
 - Distro layer not yet public, but it does boot to weston and run an app.

## Yocto

Skip this is you're already familiar with Yocto Linux.

Yocto Linux is a system of build scripts and recipes for building bespoke Linux
images. A Yocto environment is composed of several layers, generally including
the "core" layer, named "meta", along with a BSP (Board Support Package) for
the target system, and a distro layer that defines all of the libraries and
applications that will be included in the image. Yocto includes a reference
distro called Poky and BSPs for a small number of common systems, such as
x86_64.

# Building

## Dependencies

 - Yocto core "meta"
 - meta-sunxi

## Getting Started

Start with [Setting Up to Use The Yocto Project](https://www.yoctoproject.org/docs/2.0/yocto-project-qs/yocto-project-qs.html#yp-resources).

    git clone -b zeus git://git.yoctoproject.org/poky
    cd poky
    git clone -b zeus https://github.com/linux-sunxi/meta-sunxi
    git clone -b zeus https://github.com/JeremyGrosser/meta-clockwork
    source oe-init-build-env
    bitbake core-image-minimal

This will take a while. Depending on your hardware configuration, it may take
several hours. Only changed recipes and their dependencies are built, so
subsequent runs should be faster.

If all went well, you should now have some files in `tmp-glibc/deploy/images/clockwork-cpi3/`

Insert a microSD card and `dd` the
`core-image-minimal-clockwork-cpi3.sunxi-sdimg` file to it. If you don't know
how to do this, [read this guide](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md).

Put the microSD card in your cpi3 board and hold the power button for 10
seconds, or until the display turns on. If it worked, you should see a bunch of
penguins and eventually a login prompt.

# Next Steps

You may have noticed that you cannot type with a D-Pad. You could try to come
up with some obscene combination of USB adapters to get a keyboard attached to
your GameShell, but a serial console is much more usable. If you connect the
GPIO cable (the rainbow octopus thing) that came with your GameShell to a [3.3V USB-Serial](https://www.amazon.com/JBtek-WINDOWS-Supported-Raspberry-Programming/dp/B00QT7LQ88/?tag=synack-20)
adapter, you can use a terminal emulator to poke at it. Use of a serial console
is outside the scope of this README but the pinout you'll need is included
below.

## Serial Console

[From the schematic](https://github.com/clockworkpi/GameShellDocs/blob/master/clockwork_Mainboard_Schematic.pdf),
this is connector J46 in the DEBUG block on page 8.

From left to right, with the cpi3's flat-flex display connector on the left)

    1   Blue    Not Connected
    2   Green   TX
    3   Yellow  RX
    4   White   GND

The blue wire is 5V output. DO NOT FEED 5V INTO THIS PIN. Configure your serial
terminal for 115200 baud, [8n1](https://en.wikipedia.org/wiki/8-N-1).

## Yocto Distro

If you want your GameShell to do more than boot to a shell, you're going to
need a more complete Yocto distro to install some software with some graphics
or something. I'm currently working on this, but it's not ready yet. In the
meantime, you can `bitbake core-image-sato` for a desktop-like experience.

