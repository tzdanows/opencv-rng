# Use an official Python runtime as a parent image
FROM python:3.8

# Set the working directory in the container
WORKDIR /app

# Install OpenCV dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
 && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . .

# Install any needed packages
RUN pip install numpy
RUN pip install opencv-python
RUN pip install requests

# Define environment variable for the server address, key, and count
ENV ADDR="http://go-server:7890/Lurv"
ENV COUNT=1

# Run captureFrame.py when the container launches
CMD ["sh", "-c", "python captureFrame.py --addr=${ADDR} --key=Lurv --count=${COUNT}"]
