# Add repo and key
apt-get install -y curl apt-transport-https
curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
apt-get update

# Install
apt-get install -y filebeat=7.7.1

# Download wazuh config and templates
curl -so /etc/filebeat/filebeat.yml https://raw.githubusercontent.com/wazuh/wazuh/v3.12.3/extensions/filebeat/7.x/filebeat.yml
curl -so /etc/filebeat/wazuh-template.json https://raw.githubusercontent.com/wazuh/wazuh/v3.12.3/extensions/elasticsearch/7.x/wazuh-template.json
curl -s https://packages.wazuh.com/3.x/filebeat/wazuh-filebeat-0.1.tar.gz | sudo tar -xvz -C /usr/share/filebeat/module

# Update elasticsearch server IP
sed -i 's/YOUR_ELASTIC_SERVER_IP/192.168.50.23/' /etc/filebeat/filebeat.yml

# Unable and start filebeat
systemctl daemon-reload
systemctl enable filebeat.service
systemctl start filebeat.service
