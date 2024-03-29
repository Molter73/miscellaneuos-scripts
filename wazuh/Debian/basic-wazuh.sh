# Update and install required tools
apt-get update
apt-get install -y python gcc make libc6-dev curl policycoreutils automake autoconf libtool git \
                   cmake libcmocka0 libcmocka-dev lcov gdb valgrind clang-tools \
                   python3.6 python3.6-dev python3-pip

# Clone repos and remove unnecesary folders
echo "Cloning repos..."
mkdir /home/vagrant/git && cd /home/vagrant/git
git clone https://github.com/wazuh/wazuh.git
git clone https://github.com/wazuh/wazuh-qa.git

# Change ownership of repos
cd .. && chown vagrant:vagrant -R git/
