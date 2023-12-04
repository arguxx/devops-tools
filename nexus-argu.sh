# please init shebang

echo "nexus install begin"
yum update -y
yum install -y wget java-1.8.0-openjdk curl
wget https://download.sonatype.com/nexus/3/nexus-3.62.0-01-unix.tar.gz
tar -zxvf nexus-3.62.0-01-unix.tar.gz

mkdir -p /opt/nexus
mv nexus-3.62.0-01 /opt/nexus
cd /opt/nexus
ln -s nexus-3.62.0-01/bin/nexus nexus
sudo adduser nexus
sudo chown nexus:nexus /opt/nexus

cat <<EOF > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
ExecStart=/opt/nexus/nexus start
ExecStop=/opt/nexus/nexus stop
LimitNOFILE=65536
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now nexus.service

sudo firewall-cmd --zone=public --add-port=8087/tcp --permanent
sudo firewall-cmd --zone=public --add-port=8086/tcp --permanent
sudo firewall-cmd --reload

echo "installation success :) -argu"