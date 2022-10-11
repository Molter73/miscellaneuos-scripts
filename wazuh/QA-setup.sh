# Disable firewall
systemctl stop firewalld
systemctl disable firewalld

# Install Python and dependencies
pip3 install pytest freezegun jq jsonschema pyyaml==5.3 psutil paramiko distro pandas pytest-html==2.0.1 numpydoc==0.9.2

# Install wazuh_testing module
cd /home/vagrant/git/wazuh-qa/deps/wazuh_testing && pip3 install .

# Configure Wazuh
echo 'syscheck.debug=2' >> /var/ossec/etc/local_internal_options.conf
echo 'monitord.rotate_log=0' >> /var/ossec/etc/local_internal_options.conf
sed -i "s:<time-reconnect>60</time-reconnect>:<time-reconnect>99999999999</time-reconnect>:g" /var/ossec/etc/ossec.conf

# Restart Wazuh
/var/ossec/bin/ossec-control restart
