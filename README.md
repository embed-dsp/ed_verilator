
# Compile and Install of the Verilator Tool

This repository contains make file for easy compile and install of [Verilator](https://www.veripool.org/wiki/verilator).
Verilator compiles synthesizable Verilog / SystemVerilog into C++ and SystemC code.


# Prerequisites

## Fedora-27 64-bit

```
dnf install gcc-c++

#dnf install perl
#dnf install perl-devel

#dnf install redhat-rpm-config
```


# Get Source Code

## ed_verilator

```bash
git clone https://github.com/embed-dsp/ed_verilator.git
```

## Verilator

```bash
# Enter the ed_verilator directory.
cd ed_verilator

# FIXME: Only first time
# Clone the Verilator git repository.
make clone

# FIXME: Any other time
# Pull latest updates from the Verilator git repository.
make pull
```

```bash
# FIXME: Check for available versions
cd iverilog
git tag

# Edit the Makefile for selecting the Verilator source version.
vim Makefile
PACKAGE_VERSION = verilator_3_922
```


# Build

```bash
# Checkout specific version and rebuild configure.
make prepare
```

```bash
# Configure source code.
make configure
```

```bash
# Compile source code using 4 simultaneous jobs (Default: J=4).
make compile
make compile J=4
```


# Install

```bash
# Install build products.
sudo make install
```

The Verilator package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
opt/
└── veripool/
    ├── linux_x86_64/               # 64-bit binaries and libraries for Linux
    │   └── verilator_3_922/
    │       ├── bin/
    │       │   ├── verilator
    │       │       ...
    │       └── share/              # ...
    │           ├── verilator/
    │           │   ├── include/    # Include directory.
    │                   ...
    └── linux_x86/                  # 32-bit binaries and libraries for Linux
        └── verilator_3_922/
            ├── bin/
            │   ├── verilator
            │       ...
            └── share/              # ...
                ├── verilator/
                │   ├── include/    # Include directory.
                        ...
            ...
```


# Notes

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)`
    * `gcc-7.2.1`
    * `gcc-7.3.1`
