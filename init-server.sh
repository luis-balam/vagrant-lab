#!/bin/bash

# Install git for version control, pip for install python packages
echo 'Installing Server dependencies...'
sudo apt -y update && apt-get -y upgrade

# libfreetype6-dev ziblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
sudo apt-get -qq install \
  git curl unzip ansible bash-completion \
  apt-transport-https ca-certificates gnupg \
  lsb-release python3 python3-dev \
  libjpeg-dev libtiff5-dev zlib1g-dev > /dev/null 2>&1

curl -s https://bootstrap.pypa.io/get-pip.py | python3 > /dev/null 2>&1

# MYSQL CLIENT
#echo '>>>> INSTALLING MYSQL CLIENT'
#sudo apt-get install -y libmysqlclient-dev

# Install virtualenv / virtualenvwrapper
echo 'Installing and configuring virtualenv and virtualenvwrapper...'
pip install --quiet virtualenvwrapper==4.7.0 Pygments==2.1.1
mkdir ~vagrant/.virtualenvs
chown vagrant:vagrant ~vagrant/.virtualenvs
printf "\n\n# Virtualenv settings\n" >> ~vagrant/.bashrc
printf "export PYTHONPATH=/usr/lib/python3\n" >> ~vagrant/.bashrc
printf "export WORKON_HOME=~vagrant/.virtualenvs\n" >> ~vagrant/.bashrc
printf "export PROJECT_HOME=~/vagrant/src\n" >> ~vagrant/.bashrc
printf "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3\n" >> ~vagrant/.bashrc
printf "source /usr/local/bin/virtualenvwrapper.sh\n" >> ~vagrant/.bashrc


# AWS CLI
echo "Downloading awscli-v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
echo "Unzipping and expanding awscliv2.zip..."
unzip awscliv2.zip
echo "Installing cli..."
sudo ./aws/install
echo "Cleaning install files"
sudo rm -f awscliv2.zip
sudo rm -rf aws


# DOCKER
echo "Install Docker..."
echo "Uninstall old versions..."
sudo apt-get remove docker docker.io containerd runc
echo "Set up the repository..."
echo "Add Docker official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "Set up stable repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "Updating system..."
sudo apt-get update
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

if [[ $? == 0 ]]; then
  # DOCKER COMPOSE
  echo "INSTALLING DOCKER COMPOSE..."
  echo "CREATING TREE..."
  mkdir -p ~/.docker/cli-plugins/
  echo "DOWNLOADING DOCKER COMPOSE LINUX LATEST VERSION APR 2022... "
  mkdir -p ~/.docker/cli-plugins/
  curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
  echo "PERMISSION TO EXECUTE..."
  chmod +x ~/.docker/cli-plugins/docker-compose
  docker compose version
else
  echo "Error installing docker compose."
fi


if [[ $? == 0 ]]; then
  echo "ADD DOCKER TO USERGROUP..."
  sudo usermod -aG docker $USER
  newgrp docker
  #sudo chown root:docker /var/run/docker.sock
else
  echo "Error adding docker usergroup."
fi


# INSTALLING TERRAFORM ENV
mkdir .tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
tfenv install 1.2.0
tfenv use 1.2.0

# Complete
echo ""
echo "Vagrant install complete."
echo "Now try logging in:"
echo "    $ vagrant ssh"


# requirements
# docker
# curl
# aws-cli v2
# gzip
# ansible
  # ansible-galaxy
# terraform
  # tfenv
# kubectl
  # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
  # kubectl version --client --output=yaml 
# GO
# Kind ??
