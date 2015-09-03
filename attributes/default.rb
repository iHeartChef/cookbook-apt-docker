#
# Cookbook Name:: apt-docker
# Attributes:: default
#

default['apt-docker']['supported-codenames'] = {
  wheezy: true,  # Debian 7.x
  jessie: true,  # Debian 8.x
  stretch: true, # Debian 9.x
  precise: true, # Ubuntu 12.04
  trusty: true,  # Ubuntu 14.04
  utopic: true,  # Ubuntu 14.10
  vivid: true,   # Ubuntu 15.04
  wily: true,    # Ubuntu 15.10
}

uri = 'https://apt.dockerproject.org/repo'
distribution = "#{node['platform']}-#{node['lsb']['codename']}"
keyserver = 'hkp://p80.pool.sks-keyservers.net:80'
key = '58118E89F3A912897C070ADBF76221572C52609D'

default['apt-docker']['repos'].tap do |repo|
  repo['docker-main'].tap do |value|
    value['managed'] = true
    value['uri'] = uri
    value['distribution'] = distribution
    value['components'] = ['main']
    value['deb-src'] = false
    value['keyserver'] = keyserver
    value['key'] = key
  end

  repo['docker-testing'].tap do |value|
    value['managed'] = false
    value['uri'] = uri
    value['distribution'] = distribution
    value['components'] = ['testing']
    value['deb-src'] = false
    value['keyserver'] = keyserver
    value['key'] = key
  end

  repo['docker-experimental'].tap do |value|
    value['managed'] = false
    value['uri'] = uri
    value['distribution'] = distribution
    value['components'] = ['experimental']
    value['deb-src'] = false
    value['keyserver'] = keyserver
    value['key'] = key
  end
end
