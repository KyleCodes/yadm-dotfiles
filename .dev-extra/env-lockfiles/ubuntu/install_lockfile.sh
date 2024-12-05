#!/bin/bash

# Script to install packages from a lockfile
LOCKFILE="apt-lockfile.txt"

if [ ! -f "$LOCKFILE" ]; then
  echo "Error: Lockfile '$LOCKFILE' not found!"
  exit 1
fi

echo "Installing packages listed in the lockfile: $LOCKFILE"

# Read and install each package listed in the lockfile
xargs -a "$LOCKFILE" sudo apt-get install -y

echo "Installation from lockfile completed!"
