#!/bin/bash

echo "Starting scripts for go & python check and package installations..."

# Check for Go install
if ! command -v go &> /dev/null
then
    echo "Go could not be found, please install it to proceed."
    exit
fi
echo "Go install detected"

# Check for Python install
if ! command -v python3 &> /dev/null
then
    echo "Python could not be found, please install it to proceed."
    exit
fi
echo "Python install detected"

# Python Packages Setup
echo "Setting up Python environment and installing packages..."
python3 -m pip install --upgrade pip
python3 -m pip install numpy
python3 -m pip install opencv-python
python3 -m pip install requests

echo "Python packages numpy, opencv-python, and requests have been installed."
echo "Installation complete, continue in the README to run the app"