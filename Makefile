
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# Package version number (git TAG)
PACKAGE_VERSION = verilator_3_918

# Package name and version number
PACKAGE = $(PACKAGE_VERSION)


# Select between 32-bit or 64-bit machine (Default 64-bit)
ifeq ($(M),)
	M = 64
endif


# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif


CC = /usr/bin/gcc
CXX = /usr/bin/g++


ifeq ($(M), 64)
	CFLAGS = "-Wall -O2 -m64"
	CXXFLAGS = "-Wall -O2 -m64"
	PREFIX = /opt/veripool/linux_x86_64/$(PACKAGE)
else
	CFLAGS = "-Wall -O2 -m32"
	CXXFLAGS = "-Wall -O2 -m32"
	PREFIX = /opt/veripool/linux_x86/$(PACKAGE)
endif


all:
	@echo ""
	@echo "## First time"
	@echo "make clone              # Get openocd source from git repo"
	@echo "make prepare            # Checkout specific version"
	@echo "make configure [M=...]"
	@echo "make compile [J=...]"
	@echo "sudo make install"
	@echo ""
	@echo "## Any other time"
	@echo "make distclean          # Clean all build products"
	@echo "make pull               # ..."
	@echo "make prepare            # Checkout specific version"
	@echo "make configure [M=...]"
	@echo "make compile [J=...]"
	@echo "sudo make install"
	@echo ""


.PHONY: clone
clone:
	git clone http://git.veripool.org/git/verilator


.PHONY: pull
pull:
	# Discard any local changes
	cd verilator && git checkout -- .
	
	# Checkout master branch
	cd verilator && git checkout master
	
	# ...
	cd verilator && git pull


.PHONY: prepare
prepare:
	# Checkout specific version
	cd verilator && git checkout $(PACKAGE_VERSION)
	
	# Rebuild configure
	cd verilator && autoconf


.PHONY: configure
configure:
	cd verilator && ./configure CC=$(CC) CFLAGS=$(CFLAGS) CXX=$(CXX) CXXFLAGS=$(CXXFLAGS) --prefix=$(PREFIX)


.PHONY: compile
compile:
	cd verilator && make -j$(J)
	cd verilator && make README
	cd verilator && make internals.txt
	cd verilator && make verilator.txt


.PHONY: install
install:
	cd verilator && make install
	# -mv $(PREFIX)/share/verilator/bin/verilator_includer $(PREFIX)/bin
	# -mv $(PREFIX)/share/verilator/include $(PREFIX)
	# -rm -rf $(PREFIX)/share/verilator
	# -cd build/$(PACKAGE) && cp verilator_coverage.1 $(PREFIX)/share/man/man1
	-mkdir -p $(PREFIX)/share/doc
	-cd verilator && cp README $(PREFIX)/share/doc
	-cd verilator && cp internals.txt $(PREFIX)/share/doc
	-cd verilator && cp verilator.txt $(PREFIX)/share/doc


.PHONY: clean
clean:
	cd verilator && make clean


.PHONY: distclean
distclean:
	cd verilator && make distclean
