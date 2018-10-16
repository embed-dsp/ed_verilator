
# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $


PACKAGE_NAME = verilator

# Package version number (git master branch)
# PACKAGE_VERSION = master
# PACKAGE = $(PACKAGE_NAME)_$(PACKAGE_VERSION)

# Package version number (git tag)
#PACKAGE_VERSION = verilator_3_926
PACKAGE_VERSION = verilator_4_004
PACKAGE = $(PACKAGE_VERSION)

# Build for 32-bit or 64-bit (Default)
ifeq ($(M),)
	M = 64
endif

# Set number of simultaneous jobs (Default 4)
ifeq ($(J),)
	J = 4
endif

# Kernel.
KERN = $(shell ./bin/get_kernel.sh)

# Machine.
MACH = $(shell ./bin/get_machine.sh $(M))

# Architecture.
ARCH = $(KERN)_$(MACH)

# ...
CONFIGURE_FLAGS =

# Linux specifics.
ifeq ($(KERN),linux)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /opt
endif

# Cygwin specifics.
ifeq ($(KERN),cygwin)
	# Compiler.
	CC = /usr/bin/gcc
	CXX = /usr/bin/g++
	# Installation directory.
	INSTALL_DIR = /cygdrive/c/opt
endif

# MinGW specifics.
ifeq ($(KERN),mingw32)
	# Compiler.
	CC = /mingw/bin/gcc
	CXX = /mingw/bin/g++
	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# MinGW-W64 specifics.
ifeq ($(KERN),mingw64)
	# Compiler.
	CC = /mingw64/bin/gcc
	CXX = /mingw64/bin/g++
	# Installation directory.
	INSTALL_DIR = /c/opt
endif

# Installation directory.
PREFIX = $(INSTALL_DIR)/veripool/$(ARCH)/$(PACKAGE)
# EXEC_PREFIX = $(PREFIX)/$(ARCH)


all:
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
	@echo "sudo make install"
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
	cd $(PACKAGE_NAME) && ./configure CC=$(CC) CXX=$(CXX) --prefix=$(PREFIX) $(CONFIGURE_FLAGS)


.PHONY: compile
compile:
ifeq ($(KERN),mingw64)
	# NOTE: The FlexLexer.h file is not found unless we copy it to the verilator/src directory!
	cp /usr/include/FlexLexer.h verilator/src/FlexLexer.h
endif
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
ifeq ($(KERN),mingw64)
	# NOTE: ...
	-rm verilator/src/FlexLexer.h
endif


.PHONY: distclean
distclean:
	cd $(PACKAGE_NAME) && make distclean
