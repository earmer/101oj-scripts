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

# Clean up APK cache
echo "Cleaning up APK cache..."
apk cache clean

# Remove unused dependencies
echo "Removing unused packages..."
apk autoremove

# Clear the downloaded package cache
echo "Clearing package cache..."
rm -rf /var/cache/apk/*

echo "Cleanup finished!"