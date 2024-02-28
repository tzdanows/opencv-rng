# Description

Opencv-rng is a program used to generate random numbers based on photos from a connected video camera device

### Requirements
* [Go](https://golang.org/doc/install)
* [Python](https://www.python.org/downloads/)
    - numpy
    - opencv-python 
    - requests

### Clone repository and install dependencies

```bash
# clone the repository
git clone tzdanows/opencv-rng

# run in Mac/Linux terminal
chmod +x install.sh
./unix-install.sh

# run in Windows powershell terminal
./windows-install.ps1
```

### Running the server & client
```bash
# run this from the root directory (keep this running)
go run go-server/server.go
```

```bash
# run this from the root directory 
# --addr WILL NOT CHANGE
# --key is the url path in the HTTP route setup
# --count is the amount of images to view(1 per second))
# --max is the maximum number that can be generated
python3 py-client/captureFrame.py --addr="127.0.0.1:7890" --key="Lurv" --count 2 --max 127
```

### References
> Built off of [videorand](https://github.com/bazuker/videorand)