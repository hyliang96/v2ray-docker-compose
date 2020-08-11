
# uninstall docker
dpkg -l | grep -i docker

sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd.io
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce containerd.io

sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo rm -rf /var/lib/containerd
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
