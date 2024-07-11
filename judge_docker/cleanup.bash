#!/bin/bash
# This script will clean up temporary files and directories created by the install script
set -e
set -u
set -o pipefail
# Remove the GCC source directory
if [ -d /usr/src/gcc ]; then
    echo "Removing GCC source directory..."
    rm -rf /usr/src/gcc
fi

# Clean up APT cache
echo "Cleaning up APT cache..."
apt autoclean    
apt clean
apt autoremove --purge snapd
echo "Cleanup finished!"