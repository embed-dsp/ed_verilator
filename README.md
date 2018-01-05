
Compile and Install of the Verilator Tool
=========================================

This repository contains make file for easy compile and install of [Verilator](https://www.veripool.org/wiki/verilator).
Verilator compiles synthesizable Verilog / SystemVerilog into C++ and SystemC code.

Get Source Code
===============

## ed_verilator
```bash
git clone https://github.com/embed-dsp/ed_verilator.git
```

## Verilator
```bash
# Enter the ed_verilator directory.
cd ed_verilator

# Clone the Verilator git repository.
make clone

# Pull latest updates from the Verilator git repository.
make pull

# Edit the Makefile for selecting the Verilator source version.
vim Makefile
PACKAGE_VERSION = verilator_3_918
```

Build
=====
```bash
# Checkout specific version and rebuild configure.
make prepare

# Configure source code.
make configure

# Compile source code using 4 simultaneous jobs (Default: J=4).
make compile
make compile J=4
```

Install
=======
```bash
# Install build products.
sudo make install
```

The build products are installed in the following locations:
```bash
opt
└── veripool
    ├── linux_x86_64            # 64-bit binaries and libraries for Linux
    │   └── verilator_3_918
    │       ├── bin
    │       │   ├── verilator
    │       │       ...
    │       └── share           # ...
    │           ├── verilator
    │           │   ├── include # Include directory.
    │                   ...
    └── linux_x86               # 32-bit binaries and libraries for Linux
        └── verilator_3_918
            ...
```

Notes
=====

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)` and `gcc-7.2.1`
