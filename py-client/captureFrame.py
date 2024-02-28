import sys
import time
import cv2
from optparse import OptionParser
from frameRNG import serialize_frame
from postNumber import post_numbers
import numpy as np
import random

# Initializer CLI parser
parser = OptionParser()
parser.add_option("-a", "--addr", dest="addr", help="address to publish", metavar="ADDR")
parser.add_option("-k", "--key", dest="key", help="key address of the host", metavar="KEY")
parser.add_option("-c", "--count", dest="count", type="int", default=1, help="how many numbers to generate and send", metavar="COUNT")
parser.add_option("-m", "--max", dest="max_value", type="int", default=1000, help="max value for the generated number", metavar="MAX")

(options, args) = parser.parse_args()

if options.key is None:
    print("--key was not provided!")
    sys.exit()
    
if 1 >= options.max_value:
    print("min value must be less than max value")
    sys.exit()

addr = "http://127.0.0.1:7890/"
if options.addr:
    addr = options.addr if options.addr.startswith("http://") or options.addr.startswith("https://") else "http://" + options.addr
    addr = addr if addr.endswith("/") else addr + "/"

print(f"Connecting to server...")

# Video capture setup
np.seterr(over='ignore')
cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Error: Camera could not be opened.")
    sys.exit()
print(f"Camera successfully connected \U0001F4F7 \n")

# Configuration settings
chunk_size = 30 # how large to make the chunks
iterations = 5 # number of frames to capture

for i in range(options.count):
    entropy_accumulator = 0

    for i in range(iterations):
        ret, frame = cap.read()
        time.sleep(1)
        if not ret:
            print("Failed to capture frame")
            break

        width = frame.shape[1]
        height = frame.shape[0]

        # Serialize the frame to get a number
        serialized_number = serialize_frame(frame, width, height, chunk_size)
        entropy_accumulator += serialized_number

        print(f"Frame {i+1}/{iterations}: Serialized number = {serialized_number}")

        # Show the frame (optional)
        #cv2.imshow('Frame', frame)
        #if cv2.waitKey(1) & 0xFF == ord('q'):
             #break

    # Ensure entropy_accumulator is within a valid range for seeding
    entropy_accumulator = int(entropy_accumulator % (2**32))  # mod of 2^32 to keep the val in a 32-bit int range

    # Use the adjusted accumulator as the seed
    random.seed(entropy_accumulator)
    
    # Use max as the upper limit for generating the random number
    final_random_number = random.randint(1, options.max_value)

    print(f"Final randomly generated number: {final_random_number} \n")

    # send this final number to the server
    post_numbers([final_random_number], addr, options.key)

# Cleanup
cap.release()
cv2.destroyAllWindows()
