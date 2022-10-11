# Insert some necessary ssh pubkeys
echo "Adding ssh keys..."
cd /home/vagrant/.ssh
cat /vagrant/id_rsa.pub >> authorized_keys
cat /vagrant/rsync-key.pub >> authorized_keys

# Update and install required tools
yum install -y epel-release
yum install -y gcc make policycoreutils-python automake autoconf libtool git \
               cmake3 libcmocka libcmocka-devel lcov gdb valgrind nano \
               python36 python36-pip python36-devel \
               which sudo wget
yum groupinstall -y "Development Tools"

# Clone repos and remove unnecesary folders
echo "Cloning repos..."
mkdir /home/vagrant/git && cd /home/vagrant/git
git clone https://github.com/wazuh/wazuh.git
git clone https://github.com/wazuh/wazuh-qa.git

# Change ownership of repos
cd .. && chown vagrant:vagrant -R git/
