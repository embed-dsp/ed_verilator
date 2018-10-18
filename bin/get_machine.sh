#!/bin/sh

# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This shell script returns the machine name.
#
# Usage:
#   get_machine.sh      Return machine name.
#   get_machine.sh 32   Return machine name, assuming a 32-bit machine.
#   get_machine.sh 64   Return machine name, assuming a 64-bit machine.

machine=$(uname -m)

# Unify Intel/AMD machine names.
case $machine in
    i386 | i686)
        if [ "$1" == "64" ]; then
            echo "* ERROR *: 64-bit not supported on x86"
            exit 1
        else
            machine="x86"
        fi
        ;;
    x86_64 | amd64)
        if [ "$1" == "32" ]; then
            machine="x86"
        else
            machine="x86_64"
        fi
        ;;
esac

echo $machine
