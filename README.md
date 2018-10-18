
# Compile and Install of the Verilator Tool

This repository contains a **make** file for easy compile and install of [Verilator](https://www.veripool.org/wiki/verilator).
Verilator compiles synthesizable Verilog / SystemVerilog into C++ and SystemC code.

This **make** file can build the GTKWave tool on the following systems:
* Linux
* Windows
    * [MSYS2](https://www.msys2.org)/mingw64
    * [MSYS2](https://www.msys2.org)/mingw32
    * **FIXME**: [Cygwin](https://www.cygwin.com)


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
PACKAGE_VERSION = verilator_4_004
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
# Compile source code using 4 simultaneous jobs (Default).
make compile

# Compile source code using 2 simultaneous jobs.
make compile J=2
```


# Install

```bash
# Install build products.
# FIXME: sudo
sudo make install
```

The Verilator package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

FIXME: linux, arm, ...
```bash
opt/
└── veripool/
    ├── linux_x86_64/               # 64-bit binaries and libraries for Linux
    │   └── verilator_4_004/
    │       ├── bin/
    │       │   ├── verilator
    │       │       ...
    │       └── share/              # ...
    │           ├── verilator/
    │           │   ├── include/    # Include directory.
    │                   ...
    └── linux_x86/                  # 32-bit binaries and libraries for Linux
        └── verilator_4_004/
            ├── bin/
            │   ├── verilator
            │       ...
            └── share/              # ...
                ├── verilator/
                │   ├── include/    # Include directory.
                        ...
            ...
```


FIXME: windows 64-bit, mingw32, mingw64


# Tested System Configurations

System  | M=                | M=32  
--------|-------------------|-------------------
linux   | Fedora-28 64-bit  | 
mingw64 | Windows-10 64-bit |
mingw32 | Windows-10 64-bit |
cygwin  | **FIXME**         |

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)`
    * `gcc-7.2.1`
    * `gcc-7.3.1`
* `Fedora-28 (64-bit)`
    * `gcc-8.1.1`


# Prerequisites

## Fedora-27 64-bit | Fedora-28 64-bit

```
dnf install gcc-c++

dnf install perl
dnf install perl-devel
dnf install perl-Digest-SHA

dnf install redhat-rpm-config
```
