#!/usr/bin/env bash

sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
sudo apt-get install openjdk-8-jre -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get update -y
sudo apt-get install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y
sudo apt-get install elasticsearch
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-ec2 -s

cat << EOF >/etc/elasticsearch/elasticsearch.yml

cluster.name: ${elasticsearch_cluster}
network.host: _ec2:privateIpv4_
EOF

sudo service elasticsearch restart
sudo service elasticsearch start
sudo update-rc.d elasticsearch defaults 95 10


# 5601	TCP	0.0.0.0/0	elk_default_security_group
