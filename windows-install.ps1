Write-Output "Starting scripts for go & python check and package installations..."

# Check for Go install
$go = Get-Command go.exe -ErrorAction SilentlyContinue
if (-Not $go) {
    Write-Output "Go could not be found, please install it to proceed."
    Exit
}
Write-Output "Go install detected"

# Check for Python install
$python = Get-Command python.exe -ErrorAction SilentlyContinue
if (-Not $python) {
    Write-Output "Python could not be found, please install it to proceed."
    Exit
}
Write-Output "Python install detected"

# Python Packages Setup
Write-Output "Setting up Python environment and installing packages..."
python -m pip install --upgrade pip
python -m pip install numpy
python -m pip install opencv-python 
python -m pip install requests

Write-Output "Python packages numpy, opencv-python, and requests have been installed."
Write-Output "Installation complete, continue in the README to run the app"