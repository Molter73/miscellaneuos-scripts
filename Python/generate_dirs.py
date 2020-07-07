import os
import random
import string

NUM_DIRS = 10
NUM_FILES = 10

BASE_DIR = 'C:\\testdir'

if __name__ == "__main__":
    for i in range(NUM_DIRS):
        CURRENT_DIR = os.path.join(BASE_DIR, f'dir{i}')
        if not os.path.isdir(CURRENT_DIR):
            os.mkdir(CURRENT_DIR)
        for j in range(NUM_FILES):
            CURRENT_FILE = os.path.join(CURRENT_DIR, f'file{j}')
            with open(CURRENT_FILE, 'w') as f:
                f.write(random.choice(string.printable) * 1024)
