# Install windows specific utilities
apt-get update
apt-get install -y gcc-mingw-w64 nsis zip

# Install cmocka
echo "Installing cmocka..."
cd /home/vagrant/git && git clone https://git.cryptomilk.org/projects/cmocka.git
cd cmocka
sed -i '1 s/ON/OFF/g' DefineOptions.cmake
mkdir build && cd build
cmake -DCMAKE_C_COMPILER=i686-w64-mingw32-gcc -DCMAKE_C_LINK_EXECUTABLE=i686-w64-mingw32-ld -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32/ -DCMAKE_SYSTEM_NAME=Windows -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
make install
cd ../../ && rm -rf cmocka/
