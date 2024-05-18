
# Compile and Install of the Verilator Tool

This repository contains a **make** file for easy compile and install of [Verilator](https://www.veripool.org/wiki/verilator).
Verilator compiles synthesizable Verilog / SystemVerilog into C++ and SystemC code.

This **make** file can build the Verilator tool on the following systems:
* Linux
* Windows
    * [MSYS2](https://www.msys2.org)/mingw64


# Get Source Code

## ed_verilator

```bash
git clone https://github.com/embed-dsp/ed_verilator.git
```

## Verilator

```bash
# Enter the ed_verilator directory.
cd ed_verilator
```

```bash
# If this is the first time Verilator is built, then clone the Verilator git repository.
make clone
```

```bash
# Otherwise just pull the latest updates from the Verilator git repository.
make pull
```

```bash
# Edit the Makefile for selecting the Verilator version.
vim Makefile
PACKAGE_VERSION = master
# PACKAGE_VERSION = v5.024

# Edit the Makefile for selecting the SystemC version.
vim Makefile
SYSTEMC_VERSION = 2.3.3
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
    └── linux_x86_64/               # 64-bit binaries and libraries for Linux
        └── verilator-master/
            ├── bin/
            │   ├── verilator
            │       ...
            └── share/              # ...
                ├── verilator/
                │   ├── include/    # Include directory.
                        ...
```

## Windows: MSYS2/mingw64

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
    └── mingw64_x86_64/             # 64-bit binaries and libraries for Windows
        └── verilator-master/
            ├── bin/
            │   ├── verilator
            │       ...
            └── share/              # ...
                ├── verilator/
                │   ├── include/    # Include directory.
                        ...
```
