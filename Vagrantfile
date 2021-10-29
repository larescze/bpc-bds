# -*- mode: ruby -*-
# vi: set ft=ruby :

$argument_up_and_not_created = false
if ARGV[0] == "up"
    $status = %x(vagrant status)
    $argument_up_and_not_created = ($status =~ /^default\s+not\screated\s.*$/m && ARGV[0] == "up")
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.disksize.size = "40GB"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 8192
    vb.cpus = 4
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
    apt-get update
    apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io \
	  docker.io
    sudo pip install -U docker-compose
    chmod +x /usr/local/bin/docker-compose
    usermod -a -G docker vagrant
  SHELL
end
