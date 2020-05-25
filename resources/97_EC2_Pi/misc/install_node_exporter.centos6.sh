#!/bin/bash

cd /tmp
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz

tar -xvf node_exporter-0.18.1.linux-amd64.tar.gz

sudo mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/

sudo useradd -rs /bin/false node_exporter

echo "[Unit]" > /etc/systemd/system/node_exporter.service
echo "Description=Node Exporter" >> /etc/systemd/system/node_exporter.service
echo "After=network.target" >> /etc/systemd/system/node_exporter.service
echo "" >> /etc/systemd/system/node_exporter.service
echo "[Service]" >> /etc/systemd/system/node_exporter.service
echo "User=node_exporter" >> /etc/systemd/system/node_exporter.service
echo "Group=node_exporter" >> /etc/systemd/system/node_exporter.service
echo "Type=simple" >> /etc/systemd/system/node_exporter.service
echo "ExecStart=/usr/local/bin/node_exporter" >> /etc/systemd/system/node_exporter.service
echo "" >> /etc/systemd/system/node_exporter.service
echo "[Install]" >> /etc/systemd/system/node_exporter.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/node_exporter.service

sudo systemctl daemon-reload
sudo systemctl start node_exporter

sudo systemctl status node_exporter

sudo systemctl enable node_exporter