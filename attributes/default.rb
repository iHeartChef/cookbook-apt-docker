#
# Cookbook Name:: apt-docker
# Attributes:: default
#

# Debian-ish platform support for this cookbook and the Docker repository.
# Designed to be a private attribute however it can be overridden in the case
# Docker supports additional platforms and this cookbook has not been updated
# yet.
#
# This check was implemented as a result of the repo could be successfully
# installed yet not be valid for a given platform and a Docker package could
# be successfully installed as a result of it being available natively on the
# platform it which it was run which results in a false positive for the
# consumer of the cookbook.
#
# The hash key is the codename of the OS/version.  If the hash value evaluates
# to true, the OS/version is considered supported.

default['apt-docker']['supported-codenames'] = {
  wheezy: true,  # Debian 7.x
  jessie: true,  # Debian 8.x
  stretch: true, # Debian 9.x
  precise: true, # Ubuntu 12.04
  trusty: true,  # Ubuntu 14.04
  utopic: true,  # Ubuntu 14.10
  vivid: true,   # Ubuntu 15.04
  wily: true,    # Ubuntu 15.10
  xenial: true,  # Ubuntu 16.04
}

uri = 'https://apt.dockerproject.org/repo'
distribution = "#{node['platform']}-#{node['lsb']['codename']}"
keyserver = 'hkp://p80.pool.sks-keyservers.net:80'
key = '58118E89F3A912897C070ADBF76221572C52609D'

default['apt-docker']['repos'].tap do |repo|
  repo['docker-main'].tap do |value|
    # Does this cookbook manage the install of the Docker Main Repo?
    value['managed'] = true
    # URI of Docker Main Repo
    value['uri'] = uri
    # Package distribution of Docker Main Repo
    value['distribution'] = distribution
    # Docker Main Repo Package Groupings
    value['components'] = ['main']
    # Whether or not to add the Docker Main Source Repo?
    value['deb-src'] = false
    # GPG keyserver for the Docker Main Repo
    value['keyserver'] = keyserver
    # GPG fingerprint for the Docker Main Repo
    value['key'] = key
  end

  repo['docker-testing'].tap do |value|
    # Does this cookbook manage the install of the Docker Testing Repo?
    value['managed'] = false
    # URI of Docker Testing Repo
    value['uri'] = uri
    # Package distribution of Docker Testing Repo
    value['distribution'] = distribution
    # Docker Testing Repo Package Groupings
    value['components'] = ['testing']
    # Whether or not to add the Docker Main Testing Repo?
    value['deb-src'] = false
    # GPG keyserver for the Docker Testing Repo
    value['keyserver'] = keyserver
    # GPG fingerprint for the Docker Testing Repo
    value['key'] = key
  end

  repo['docker-experimental'].tap do |value|
    # Does this cookbook manage the install of the Docker Experimental Repo?
    value['managed'] = false
    # URI of Docker Experimental Repo
    value['uri'] = uri
    # Package distribution of Docker Experimental Repo
    value['distribution'] = distribution
    # Docker Experimental Repo Package Groupings
    value['components'] = ['experimental']
    # Whether or not to add the Docker Experimental Source Repo?
    value['deb-src'] = false
    # GPG keyserver for the Docker Experimental Repo
    value['keyserver'] = keyserver
    # GPG fingerprint for the Docker Experimental Repo
    value['key'] = key
  end
end
