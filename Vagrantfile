# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.provision :shell, path: "bootstrap.sh"
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |v|
    v.gui = true
    v.memory = 2048
    v.cpus = 1
    v.name = "box"
    v.customize ["modifyvm", :id, "--audio", "coreaudio"]
    #v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--vram", "12"]
  end
end
