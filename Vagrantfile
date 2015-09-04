script = <<SCRIPT
# Install Needed Gems
su -c "cd /vagrant; gem install bundler; bundle install --without ci-integration" - vagrant
SCRIPT

Vagrant.configure('2') do |config|
  config.vm.box = 'st-isidore-de-seville/trusty64-rvm-docker'

  # these values are reset to Vagrant defaults as the base Vagrant box needed
  #  more memory and CPU for building Gecode
  config.vm.provider 'virtualbox' do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.provision 'shell', inline: script
end
