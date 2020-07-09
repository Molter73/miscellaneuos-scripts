import os
import random
import string

NUM_DIRS = 10
NUM_FILES = 10
RECURSION_LEVELS = 10

BASE_DIR = 'C:\\testdir'


def fill_directory(path: str, dirs=10, files=10):
    for i in range(dirs):
        current_dir = os.path.join(path, f'dir{i}')
        if not os.path.isdir(current_dir):
            os.mkdir(current_dir)
        for j in range(files):
            current_file = os.path.join(current_dir, f'file{j}')
            with open(current_file, 'w') as f:
                f.write(random.choice(string.printable) * 1024)


if __name__ == "__main__":
    current_dir = BASE_DIR
    fill_directory(current_dir, NUM_DIRS, NUM_FILES)

    for i in range(RECURSION_LEVELS):
        current_dir = os.path.join(current_dir, f'level{i}')
        if not os.path.isdir(current_dir):
            os.mkdir(current_dir)
        fill_directory(current_dir, NUM_DIRS, NUM_FILES)
