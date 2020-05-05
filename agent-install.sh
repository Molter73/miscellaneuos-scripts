# Compiling Wazuh manager
cd /home/vagrant/git/wazuh/src && git checkout stable
make -j$(nproc) deps && make -j$(nproc) TARGET=agent DEBUG=1

# Configure Wazuh for unattended installation
cd ../etc/
sed -i -e '/^#.*USER_LANGUAGE=\"en\"/s/^# //' \
    -e '/^#.*USER_NO_STOP=\"y\"/s/^# //' \
    -e '/^#.*USER_INSTALL_TYPE=\"agent\"/s/^#//' \
    -e "/^#.*USER_DIR=\"\/var\/ossec\"/s/^#//" \
    -e "/^#.*USER_ENABLE_ACTIVE_RESPONSE=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_SYSCHECK=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_ROOTCHECK=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_OPENSCAP=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_SYSCOLLECTOR=\"y\"/s/^#//" \
    -e "s/^# USER_AGENT_SERVER_IP=\"1\.2\.3\.4\"/USER_AGENT_SERVER_IP=\"192\.168\.50\.20\"/" \
    -e "s/^#USER_CREATE_SSL_CERT=\"y\"$/USER_CREATE_SSL_CERT=\"n\"/" \
    -e "s/^#USER_CA_STORE=.*$/USER_CA_STORE=\"n\"/" preloaded-vars.conf

# Install
cd ../ && ./install.sh

# clean-up
cd ../ && chown -R vagrant:vagrant wazuh/*
cd wazuh/ && git checkout -- .
cd src/ && make clean-deps && make clean

# Register and start agent
/var/ossec/bin/agent-auth -m 192.168.50.20
/var/ossec/bin/ossec-control start
