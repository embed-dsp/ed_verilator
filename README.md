
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
Get the code for this component to a local directory on your PC.

```bash
git clone https://github.com/embed-dsp/ed_verilator.git
```

## Verilator
Get the code for Verilator.

```bash
# Enter the ed_verilator directory.
cd ed_verilator
```

If this is the first time Verilator is built, then ...
```bash
# Clone the Verilator git repository.
make clone
```

Otherwise just pull the latest updates ...
```bash
# Pull latest updates from the Verilator git repository.
make pull
```

Edit the **Makefile** for selecting the Verilator source version.
```bash
# Edit Makefile ...
vim Makefile

# ... and set the Verilator source version.
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
```

```bash
# Compile source code using 2 simultaneous jobs.
make compile J=2
```


# Install

## Linux

```bash
# Install build products.
sudo make install
```

The Verilator package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
/opt/
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

## Windows: MSYS2/mingw64 & MSYS2/mingw32

```bash
# Install build products.
make install
```

The Verilator package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
/c/opt/
└── veripool/
    ├── mingw64_x86_64/             # 64-bit binaries and libraries for Windows
    │   └── verilator_4_004/

    ├── mingw32_x86_64/             # 32-bit binaries and libraries for Windows
    │   └── verilator_4_004/
```

## Windows: Cygwin

```bash
# Install build products.
make install
```

The Verilator package does NOT install correctly according to the
[GNU Coding Standards](https://www.gnu.org/prep/standards/standards.html).
The build products are therefore installed in the following locations in order 
to allow separate installation for different architectures:

```bash
/cygdrive/c/opt/
└── veripool/
    ├── cygwin_x86_64/             # 64-bit binaries and libraries for Windows
    │   └── verilator_4_004/

    ├── cygwin_x86/                 # 32-bit binaries and libraries for Windows
    │   └── verilator_4_004/
```


# Tested System Configurations

System  | M=                | M=32  
--------|-------------------|-------------------
linux   | Fedora-27 64-bit  | 
linux   | Fedora-28 64-bit  | 
mingw64 | Windows-10 64-bit |
mingw32 | Windows-10 64-bit |
cygwin  | **FIXME**         |


# Prerequisites

## Fedora-27 64-bit | Fedora-28 64-bit

```
dnf install gcc-c++

dnf install perl
dnf install perl-devel
dnf install perl-Digest-SHA

dnf install redhat-rpm-config
```
