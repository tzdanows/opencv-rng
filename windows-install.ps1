Write-Output "Starting installation..."

# Check for Go installation
$go = Get-Command go.exe -ErrorAction SilentlyContinue
if (-Not $go) {
    Write-Output "Go could not be found, please install it to proceed."
    Exit
}

# Check for Python installation
$python = Get-Command python.exe -ErrorAction SilentlyContinue
if (-Not $python) {
    Write-Output "Python could not be found, please install it to proceed."
    Exit
}

# Go Server Setup
Write-Output "Setting up Go server..."
Set-Location -Path .\go-server
go mod tidy
go build -o server .
Set-Location -Path ..

# Python Client Setup
Write-Output "Setting up Python client..."
Set-Location -Path .\py-client
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install numpy opencv-python requests
Set-Location -Path ..

Write-Output "Installation complete. Please follow the README for instructions on how to run the applications."
