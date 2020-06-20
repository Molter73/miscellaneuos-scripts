# Install NodeJS
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get update
apt-get install nodejs

# Install wazuh-api
cd /home/vagrant/git
git clone https://github.com/wazuh/wazuh-api.git
cd wazuh-api

git checkout stable && ./install_api.sh

cd .. && chown -R vagrant:vagrant wazuh-api
