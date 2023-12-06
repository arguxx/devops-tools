# Please init SheBang

echo "Gitlab-CE install begin :) -- Argu"
yum update -y

sudo systemctl enable sshd
sudo systemctl start sshd

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld

sudo yum install postfix
sudo systemctl enable postfix
sudo systemctl start postfix

# Gitlab Package

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash


IP_ADDRESS=$(echo $(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'))
sudo EXTERNAL_URL="$IP_ADDRESS" yum install -y gitlab-ce

echo "Username: root"
cat /etc/gitlab/initial_root_password

echo "installation success :) -- Argu"
