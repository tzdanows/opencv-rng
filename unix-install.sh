#!/bin/bash

echo "Starting installation..."

# Check if Go is installed
if ! command -v go &> /dev/null
then
    echo "Go could not be found, please install it to proceed."
    exit
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null
then
    echo "Python could not be found, please install it to proceed."
    exit
fi

# Go Server Setup
echo "Setting up Go server..."
cd go-server || exit
go mod tidy
go build -o server .
cd ..

# Py Client Setup
echo "Setting up Python client..."
cd py-client || exit
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install numpy opencv-python requests
cd ..

echo "Installation complete. Please follow the README for instructions on how to run the applications."