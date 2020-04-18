# Install wine
# Add 32 bit architecture
dpkg --add-architecture i386

# Add key
echo "Adding winhq key"
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -

###  Add repository (Ubuntu 18.04)
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
add-apt-repository ppa:cybermax-dexter/sdl2-backport

# Install
apt update
apt install -y --install-recommends winehq-stable

# Link wine binary
ln -s /opt/wine-stable/bin/wine /usr/bin/

# Set environment variables
echo 'export WINEARCH=win32' >> /home/vagrant/.bashrc
echo 'export WINEPATH="/usr/i686-w64-mingw32/lib;/home/vagrant/git/wazuh/src"' >> /home/vagrant/.bashrc
