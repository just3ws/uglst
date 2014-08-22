# -*- mode: ruby -*-
# vi: set ft=ruby :

# Load in custom vagrant settings
require 'yaml'
custom_settings = File.file?('vagrant.yml') ?  YAML.load_file('vagrant.yml') : {}

puts '== Using Custom Vagrant Settings =='
puts custom_settings.inspect

VAGRANTFILE_API_VERSION = '2'

$box = 'ubuntu/trusty64'
$provision = 'vagrant/bootstrap.sh'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = $box
  config.vm.provision :shell do |s|
    s.path = $provision
  end

  config.ssh.keep_alive = true
  config.ssh.forward_agent = true

  if network_settings = custom_settings['network']
    config.vm.network :private_network, ip: "#{network_settings['ip_address']}"
  end

  set_port_mapping_for(config, 'postgres',      5432,  custom_settings)
  set_port_mapping_for(config, 'redis',         6379,  custom_settings)
  set_port_mapping_for(config, 'rails',         3000,  custom_settings, true)

  if sync_settings = custom_settings['sync']
    config.vm.synced_folder '.', '/home/vagrant/app', nfs: sync_settings['use_nfs']
  end

  config.vm.provider :virtualbox do |vb|
    # Use custom settings unless they don't exist
    if virtualbox_settings = custom_settings['virtualbox']
      vb.customize ['modifyvm', :id, '--cpus',   "#{virtualbox_settings['cpus']   || 2}"]
      vb.customize ['modifyvm', :id, '--memory', "#{virtualbox_settings['memory'] || 2048}"]
    else
      vb.customize ['modifyvm', :id, '--cpus',   '2']
      vb.customize ['modifyvm', :id, '--memory', '2048']
    end

    vb.customize ['modifyvm', :id, '--ioapic', 'on']

    # https://github.com/mitchellh/vagrant/issues/1807
    # whatupdave: my VM was super slow until I added these:
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    # seems to be safe to run: https://github.com/griff/docker/commit/e5239b98598ece4287c1088e95a2eaed585d2da4
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
    config.vbguest.no_remote = false
  else
    puts "Please install the 'vagrant-vbguest' plugin"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box

    ## OPTIONAL: If you are using VirtualBox, you might want to use that to enable
    ## NFS for shared folders. This is also very useful for vagrant-libvirt if you
    ## want bi-directional sync
    #config.cache.synced_folder_opts = {
      #type: :nfs,
      ## The nolock option can be useful for an NFSv3 client that wants to avoid the
      ## NLM sideband protocol. Without this option, apt-get might hang if it tries
      ## to lock files needed for /var/cache/* operations. All of this can be avoided
      ## by using NFSv4 everywhere. Please note that the tcp option is not the default.
      #mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
    #}
    # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end
end

def set_port_mapping_for(config, service, guest_port, settings, force = false)
  if settings['network'] && settings['network']['port_mappings'] && settings['network']['port_mappings'][service]
    host_port = settings['network']['port_mappings'][service]
    puts " !! Setting up port mapping rule for #{service} host:#{host_port} => guest:#{guest_port}"
    config.vm.network(:forwarded_port, guest: guest_port,  host: host_port)
  else
    # no host port mapping was defined
    if force
      # but we want to force a mapping for the default ports
      puts " !! Setting up port mapping rule for #{service} host:#{guest_port} => guest:#{guest_port}"
      config.vm.network(:forwarded_port, guest: guest_port,  host: guest_port)
    end
  end
end
