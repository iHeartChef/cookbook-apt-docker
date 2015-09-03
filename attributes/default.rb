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
