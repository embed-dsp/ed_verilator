
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


CC = /usr/bin/gcc
CXX = /usr/bin/g++

PACKAGE_NAME = verilator

# Package version number (git master branch)
# PACKAGE_VERSION = master
# PACKAGE = $(PACKAGE_NAME)_$(PACKAGE_VERSION)

# Package version number (git tag)
PACKAGE_VERSION = verilator_3_918
PACKAGE = $(PACKAGE_VERSION)

# Architecture.
ARCH = $(shell ./bin/get_arch.sh)

# Installation.
PREFIX = /opt/veripool/$(ARCH)/$(PACKAGE)
# PREFIX = /opt/veripool/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif


all:
	@echo ""
	@echo "## Get the source"
	@echo "make clone              # Get openocd source from git repo"
	@echo "make pull               # ..."
	@echo ""
	@echo "## Build"
	@echo "make prepare            # Checkout specific version"
	@echo "make configure [M=...]"
	@echo "make compile [J=...]"
	@echo ""
	@echo "## Install"
	@echo "sudo make install"
	@echo ""
	@echo "## Cleanup"
	@echo "make distclean          # Clean all build products"
	@echo "make clean"
	@echo ""


.PHONY: clone
clone:
	git clone http://git.veripool.org/git/verilator


.PHONY: pull
pull:
	# Discard any local changes
	cd $(PACKAGE_NAME) && git checkout -- .
	
	# Checkout master branch
	cd $(PACKAGE_NAME) && git checkout master
	
	# ...
	cd $(PACKAGE_NAME) && git pull


.PHONY: prepare
prepare:
	# Checkout specific version
	cd $(PACKAGE_NAME) && git checkout $(PACKAGE_VERSION)
	
	# Rebuild configure
	cd $(PACKAGE_NAME) && autoconf


.PHONY: configure
configure:
	cd $(PACKAGE_NAME) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX)


.PHONY: compile
compile:
	cd $(PACKAGE_NAME) && make -j$(J)
	cd verilator && make README
	cd verilator && make internals.txt
	cd verilator && make verilator.txt


.PHONY: install
install:
	cd $(PACKAGE_NAME) && make install
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
	cd $(PACKAGE_NAME) && make clean


.PHONY: distclean
distclean:
	cd $(PACKAGE_NAME) && make distclean
