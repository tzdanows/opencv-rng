# Description

Opencv-rng is a program used to generate random numbers based on camera output

### Requirements
* Docker
* [Go](https://golang.org/doc/install)
* [Python](https://www.python.org/downloads/)
    - numpy
    - opencv-python 
    - requests

```bash
pip install numpy
pip install opencv-python
pip install requests
git clone tzdanows/opencv-rng
```

### Running with docker
```bash
# todo

```

### Manually running without docker
```bash
# from root directory (keep this up)
go run go-server/server.go`
```

```bash
# from root directory 
# --key is the url path in the HTTP route setup
# --count is the amount of images to view(1 per second))
python3 py-client/captureFrame.py --addr="127.0.0.1:7890" --key="Lurv" --count 1
```

### References
> Built off of [videorand](https://github.com/bazuker/videorand)