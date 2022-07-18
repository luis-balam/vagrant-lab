# -*- mode: ruby -*-
# vi: set ft=ruby :


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-22.04"
  #config.vm.box = "generic/ubuntu2204"
  
  #-----------
  #  STORAGE
  #-----------
  config.vm.synced_folder "C:\\Dev\\src", "/home/vagrant/src"

  #-------------
  #  RESOURCES
  #-------------
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end
  #config.vm.provider "virtualbox" do |vb|
  #  vb.memory = 2048
  #  vb.cpus = 2
  #end

  #---------------------------
  #  PLUGIN VAGRANT VB GUEST
  #---------------------------
  #config.vagrant.plugins = "vagrant-vbguest"

  #-------------------
  #  SERVER SETTINGS
  #------------------
  config.vm.define "ubuntu2204" do |ubuntu|
      ubuntu.vm.hostname = "luislab"
  end

  # NETWORK
  #config.vm.network "private_network", ip: "192.168.33.10"
  #config.vm.network "public_network"
  #config.vm.network "forwarded_port", guest: 80, host: 8080
  #config.vm.network "public_network", bridge: "BRIDGE"
  #config.vm.network "forwarded_port", guest: 8000, host: 8000, host_ip: "127.0.0.1"
  #config.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh"


  # PROVISION
  config.vm.provision:shell, path: "init-server.sh"
  #config.vm.provision:shell, inline: <<-SHELL
  #    echo "root:rootroot" | sudo chpasswd
  #    #sudo timedatectl set-timezone Asia/Ho_Chi_Minh
  #SHELL
  #config.vm.provision "shell" do |s|
  #  ssh_pub_key = File.readlines("/home/mobaxterm/.ssh/id_rsa.pub").first.strip
  #  s.inline = <<-SHELL
  #  echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
  #  echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
  #SHELL
  #end
  #ssh_pub_key = File.readlines("/home/mobaxterm/.ssh/id_rsa.pub").first.strip
  #config.vm.provision:shell, inline: <<-SHELL
  #  echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
  #  echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
  #SHELL

  #config.vm.provision "shell" do |s|
  #  ssh_pub_key = File.readlines("C:\\Users\\Luis.Barrales\\.ssh\\id_rsa.pub").first.strip
  #  s.inline = <<-SHELL
  #    echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
  #    echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
  #  SHELL
  #end


end
