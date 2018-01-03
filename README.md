
Compile and Install of the Verilator Tool
=========================================

This repository contains make file for easy compile and install of the Verilator Tool.
Verilator compiles synthesizable Verilog / SystemVerilog into C++ and SystemC code.

Get tool and source code
========================

## ed_verilator
```bash
git clone https://github.com/embed-dsp/ed_verilator.git
```

## Verilator Source
```bash
# Enter the ed_verilator directory.
cd ed_verilator

# Clone Verilator repository.
make clone

# Pull latest updates from Verilator repository.
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

# Configure source code for 64-bit compile (Default: M=64).
make configure
make configure M=64

# Configure source code for 32-bit compile.
make configure M=32

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
    │       └── share
    │           ├── verilator
    │           │   ├── include # Include directory.
    │                   ...
    └── linux_x86               # 32-bit binaries and libraries for Linux
        └── verilator_3_918
            ...
```

Notes
=====
