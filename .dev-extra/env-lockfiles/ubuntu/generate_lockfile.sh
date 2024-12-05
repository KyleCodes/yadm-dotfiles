#!/bin/bash

# Script to create a lockfile for installed apt packages
LOCKFILE="apt-lockfile.txt"

echo "Generating lockfile of installed packages: $LOCKFILE"

# Get a list of explicitly installed packages and write to the lockfile
apt-mark showmanual >"$LOCKFILE"

echo "Lockfile created successfully!"
