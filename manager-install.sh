# Compiling Wazuh manager
cd /home/vagrant/git/wazuh/src && git checkout 3.12
make deps && make TARGET=server DEBUG=1

# Configure Wazuh for unattended installation
cd ../etc
sed -i -e "/^#.*USER_LANGUAGE=\"en\"/s/^# //" \
    -e "/^#.*USER_NO_STOP=\"y\"/s/^# //" \
    -e "/^#.*USER_INSTALL_TYPE=\"server\"/s/^#//" \
    -e "/^#.*USER_DIR=\"\/var\/ossec\"/s/^#//" \
    -e "/^#.*USER_ENABLE_ACTIVE_RESPONSE=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_SYSCHECK=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_ROOTCHECK=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_OPENSCAP=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_SYSCOLLECTOR=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_AUTHD=\"y\"/s/^#//" \
    -e "s/^#USER_ENABLE_EMAIL=.*$/USER_ENABLE_EMAIL=\"n\"/" \
    -e "/^#.*USER_AUTO_START=\"y\"/s/^#//" \
    -e "/^#.*USER_ENABLE_SYSLOG=\"y\"/s/^#//" \
    -e "s/^#USER_WHITE_LIST=.*$/USER_WHITE_LIST=\"n\"/" preloaded-vars.conf
# Install
cd ../ && ./install.sh

# clean-up
cd ../ && chown -R vagrant:vagrant wazuh/*
git checkout -- .
cd src/ && make clean-deps && make clean
