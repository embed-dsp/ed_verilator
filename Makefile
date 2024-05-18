
# Copyright (c) 2018-2024 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


PACKAGE_NAME = verilator

# Package version number (git tag)
PACKAGE_VERSION = master
# PACKAGE_VERSION = v5.024
PACKAGE = $(PACKAGE_NAME)-$(PACKAGE_VERSION)

# SystemC version.
SYSTEMC_VERSION = 2.3.3

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
	SYSTEM = mingw64
endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Set number of simultaneous jobs (Default 8)
ifeq ($(J),)
	J = 8
endif

# System configuration.
CONFIGURE_FLAGS =

# Configuration for linux system.
ifeq ($(SYSTEM),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++

	# SystemC Installation.
	export SYSTEMC_INCLUDE=/opt/systemc/$(ARCH)/systemc-$(SYSTEMC_VERSION)/include
	export SYSTEMC_LIBDIR=/opt/systemc/$(ARCH)/systemc-$(SYSTEMC_VERSION)/lib-linux64

	# Installation directory.
	INSTALL_DIR = /opt
endif

# Configuration for mingw64 system.
ifeq ($(SYSTEM),mingw64)
	# Compiler.
	CC = /mingw64/bin/gcc
	CXX = /mingw64/bin/g++

	# SystemC Installation.
	export SYSTEMC_INCLUDE=/c/opt/systemc/$(ARCH)/systemc-$(SYSTEMC_VERSION)/include
	export SYSTEMC_LIBDIR=/c/opt/systemc/$(ARCH)/systemc-$(SYSTEMC_VERSION)/lib-mingw

	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Installation directory.
PREFIX = $(INSTALL_DIR)/veripool/$(ARCH)/$(PACKAGE)

# ==============================================================================

all:
	@echo "ARCH   = $(ARCH)"
	@echo "PREFIX = $(PREFIX)"
	@echo "SYSTEMC_INCLUDE = $(SYSTEMC_INCLUDE)"
	@echo "SYSTEMC_LIBDIR  = $(SYSTEMC_LIBDIR)"
	@echo ""
	@echo "## Get Source Code"
	@echo "make clone"
	@echo "make pull"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo "make configure"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "[sudo] make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo "make distclean"
	@echo ""


.PHONY: clone
clone:
	git clone http://git.veripool.org/git/verilator


.PHONY: pull
pull:
	# Discard any local changes
	# cd $(PACKAGE_NAME) && git checkout -- .
	cd $(PACKAGE_NAME) && git reset --hard

	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master

	# ...
	cd $(PACKAGE_NAME) && git pull


.PHONY: prepare
prepare:
	# Discard any local changes
	# cd $(PACKAGE_NAME) && git checkout -- .
	cd $(PACKAGE_NAME) && git reset --hard

	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE_VERSION)

	# Rebuild configure
	cd $(PACKAGE_NAME) && autoconf


.PHONY: configure
configure:
	cd $(PACKAGE_NAME) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX) $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
	# NOTE: The FlexLexer.h file is not found when using MSYS2/mingw* unless we copy it to the verilator/src directory!
ifeq ($(SYSTEM),mingw64)
	cp -a /usr/include/FlexLexer.h verilator/src/FlexLexer.h
endif
	cd $(PACKAGE_NAME) && make -j$(J)
	# cd $(PACKAGE_NAME) && make verilator.pdf
	# cd verilator && make README
	# cd verilator && make internals.txt
	# cd verilator && make verilator.txt


.PHONY: install
install:
	cd $(PACKAGE_NAME) && make install
	-mkdir -p $(PREFIX)/share/doc
	-cd $(PREFIX)/share/doc && wget --no-check-certificate -nc https://www.veripool.org/ftp/verilator_doc.pdf
	# -cd $(PACKAGE_NAME)/docs/_build/latex && cp verilator.pdf $(PREFIX)/share/doc
	# -mv $(PREFIX)/share/verilator/bin/verilator_includer $(PREFIX)/bin
	# -mv $(PREFIX)/share/verilator/include $(PREFIX)
	# -rm -rf $(PREFIX)/share/verilator
	# -cd build/$(PACKAGE) && cp verilator_coverage.1 $(PREFIX)/share/man/man1
	# -cd verilator && cp README $(PREFIX)/share/doc
	# -cd verilator && cp internals.txt $(PREFIX)/share/doc
	# -cd verilator && cp verilator.txt $(PREFIX)/share/doc


.PHONY: clean
clean:
	cd $(PACKAGE_NAME) && make clean
	# NOTE: Remove the FlexLexer.h file.
ifeq ($(SYSTEM),mingw64)
	-rm verilator/src/FlexLexer.h
endif


.PHONY: distclean
distclean:
	cd $(PACKAGE_NAME) && make distclean
