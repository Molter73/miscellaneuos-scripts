import random
import string

FILE_TO_FILL = 'C:\\testdir\\dir0\\file0'
NUM_BLOCKS = 5000
BLOCK_SIZE = 1024

if __name__ == "__main__":
    with open(FILE_TO_FILL, 'a') as f:
        for i in range(NUM_BLOCKS):
            f.write(random.choice(string.printable) * BLOCK_SIZE)
