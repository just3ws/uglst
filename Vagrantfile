# -*- mode: ruby -*-
# vi: set ft=ruby :

raise "Missing vagrant.yml." unless File.exists?('vagrant.yml')
raise "Missing .env file." unless File.exists?('.env')









require 'yaml'
custom_settings = File.file?('vagrant.yml') ? YAML.load_file('vagrant.yml') : {}

puts '== Using Custom Vagrant Settings =='
puts custom_settings.inspect



VAGRANTFILE_API_VERSION = '2'

box = 'ubuntu/trusty64'
provision = 'vagrant/bootstrap.sh'


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = box
  config.vm.provision :shell do |s|
    s.path = provision
  end

  config.ssh.keep_alive = true
  config.ssh.forward_agent = true

  if network_settings = custom_settings['network']
    config.vm.network :private_network, ip: "#{network_settings['ip_address']}"
  end

  set_port_mapping_for(config, 'elasticsearch', 9200,  custom_settings)
  set_port_mapping_for(config, 'memcached',     11211, custom_settings)
  set_port_mapping_for(config, 'postgres',      5432,  custom_settings)
  set_port_mapping_for(config, 'redis',         6379,  custom_settings)

  config.vm.synced_folder '.', '/home/vagrant/app', nfs: custom_settings['use_nfs']

  config.vm.provider :virtualbox do |vb|
    if virtualbox_settings = custom_settings['virtualbox']
      vb.customize ['modifyvm', :id, '--cpus', "#{virtualbox_settings['cpus'] || 2}"]
      vb.customize ['modifyvm', :id, '--memory', "#{virtualbox_settings['memory'] || 2048}"]
    else
      vb.customize ['modifyvm', :id, '--cpus', '2']
      vb.customize ['modifyvm', :id, '--memory', '2048']
    end

    vb.customize ['modifyvm', :id, '--ioapic', 'on']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end

  if Vagrant.has_plugin?('vagrant-vbguest')
    config.vbguest.auto_update = true
    config.vbguest.no_remote = false
  else
    puts "Please install the 'vagrant-vbguest' plugin"
  end

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  else
    puts "Please install the 'vagrant-cachier' plugin"
  end
end

def set_port_mapping_for(config, service, guest_port, settings, force = false)
  if settings['network'] && settings['network']['port_mappings'] && settings['network']['port_mappings'][service]
    host_port = settings['network']['port_mappings'][service]
    puts " !! Setting up port mapping rule for #{service} host:#{host_port} => guest:#{guest_port}"
    config.vm.network(:forwarded_port, guest: guest_port, host: host_port)
  else
    # no host port mapping was defined
    if force
      # but we want to force a mapping for the default ports
      puts " !! Setting up port mapping rule for #{service} host:#{guest_port} => guest:#{guest_port}"
      config.vm.network(:forwarded_port, guest: guest_port, host: guest_port)
    end
  end
end
