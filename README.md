apt-docker Cookbook
====================
[![Build Status](https://travis-ci.org/st-isidore-de-seville/cookbook-apt-docker.svg?branch=master)](https://travis-ci.org/st-isidore-de-seville/cookbook-apt-docker)
[![Chef Cookbook](https://img.shields.io/cookbook/v/apt-docker.svg)](https://supermarket.chef.io/cookbooks/apt-docker)

Installs/Configures apt Docker Vendor-Specific Repositories.

This cookbook installs & configures apt Docker repositories per
https://get.docker.com/.

Requirements
------------
- Chef 11 or higher
- Ruby 1.9 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories
- [apt Cookbook](https://supermarket.chef.io/cookbooks/apt)

Attributes
----------
#### apt-docker::default
The default recipe is for installing & configuring the apt Docker repostories.
Any attribute supported by the [apt cookbook](https://github.com/chef-cookbooks/apt#parameters)
is supported by this cookbook and can be used to override attributes in this
cookbook.

Per https://get.docker.com/, there are currently three repositories for Docker:
main, testing & experimental.  Main is the stable repository.  Testing is for
test builds (ie. release candidates).  Experimental is for experimental builds.

- `['apt-docker']['supported-codenames']`
  - _Type:_ Hash

  - _Description:_

    Debian-ish platform support for this cookbook and the Docker repository.
    Designed to be a private attribute however it can be overridden in the case
    Docker supports additional platforms and this cookbook has not been updated
    yet.

    This check was implemented as a result of the repo could be successfully
    installed yet not be valid for a given platform and a Docker package could
    be successfully installed as a result of it being available natively on the
    platform it which it was run which results in a false positive for the
    consumer of the cookbook.

    The hash key is the codename of the OS/version.  If the hash value evaluates
    to true, the OS/version is considered supported.

  - _Default:_

    ```ruby
    {
      wheezy: true,  # Debian 7.x
      jessie: true,  # Debian 8.x
      stretch: true, # Debian 9.x
      precise: true, # Ubuntu 12.04
      trusty: true,  # Ubuntu 14.04
      utopic: true,  # Ubuntu 14.10
      vivid: true,   # Ubuntu 15.04
      wily: true,    # Ubuntu 15.10
    }
    ```
- Docker Main Repo
  - `['apt-nginx']['repos']['docker-main']['managed']`
    - _Type:_ Boolean
    - _Description:_ Does this cookbook manage the install of the Docker Main
      Repo?
    - _Default:_ `true`
  - `['apt-nginx']['repos']['docker-main']['uri']`
    - _Type:_ String
    - _Description:_ URI of Docker Main Repo
    - _Default:_ `https://apt.dockerproject.org/repo`
  - `['apt-nginx']['repos']['docker-main']['distribution']`
    - _Type:_ String
    - _Description:_ Package distribution of Docker Main Repo
    - _Default:_ `#{node['platform']}-#{node['lsb']['codename']}`
  - `['apt-nginx']['repos']['docker-main']['components']`
    - _Type:_ String
    - _Description:_ Docker Main Repo Package Groupings
    - _Default:_ `['main']`
  - `['apt-nginx']['repos']['docker-main']['deb-src']`
    - _Type:_ String
    - _Description:_ Whether or not to add the Docker Main Source Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['docker-main']['keyserver']`
    - _Type:_ String
    - _Description:_ GPG keyserver for the Docker Main Repo
    - _Default:_ `hkp://p80.pool.sks-keyservers.net:80`
  - `['apt-nginx']['repos']['docker-main']['key']`
    - _Type:_ String
    - _Description:_ GPG fingerprint for the Docker Main Repo
    - _Default:_ `58118E89F3A912897C070ADBF76221572C52609D`
- Docker Testing Repo
  - `['apt-nginx']['repos']['docker-testing']['managed']`
    - _Type:_ Boolean
    - _Description:_ Does this cookbook manage the install of the Docker Testing
      Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['docker-testing']['uri']`
    - _Type:_ String
    - _Description:_ URI of Docker Testing Repo
    - _Default:_ `https://apt.dockerproject.org/repo`
  - `['apt-nginx']['repos']['docker-testing']['distribution']`
    - _Type:_ String
    - _Description:_ Package distribution of Docker Testing Repo
    - _Default:_ `#{node['platform']}-#{node['lsb']['codename']}`
  - `['apt-nginx']['repos']['docker-testing']['components']`
    - _Type:_ String
    - _Description:_ Docker Testing Repo Package Groupings
    - _Default:_ `['testing']`
  - `['apt-nginx']['repos']['docker-testing']['deb-src']`
    - _Type:_ String
    - _Description:_ Whether or not to add the Docker Testing Source Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['docker-testing']['keyserver']`
    - _Type:_ String
    - _Description:_ GPG keyserver for the Docker Testing Repo
    - _Default:_ `hkp://p80.pool.sks-keyservers.net:80`
  - `['apt-nginx']['repos']['docker-testing']['key']`
    - _Type:_ String
    - _Description:_ GPG fingerprint for the Docker Testing Repo
    - _Default:_ `58118E89F3A912897C070ADBF76221572C52609D`
- Docker Experimental Repo
  - `['apt-nginx']['repos']['docker-experimental']['managed']`
    - _Type:_ Boolean
    - _Description:_ Does this cookbook manage the install of the Docker
      Experimental Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['docker-experimental']['uri']`
    - _Type:_ String
    - _Description:_ URI of Docker Experimental Repo
    - _Default:_ `https://apt.dockerproject.org/repo`
  - `['apt-nginx']['repos']['docker-experimental']['distribution']`
    - _Type:_ String
    - _Description:_ Package distribution of Docker Experimental Repo
    - _Default:_ `#{node['platform']}-#{node['lsb']['codename']}`
  - `['apt-nginx']['repos']['docker-experimental']['components']`
    - _Type:_ String
    - _Description:_ Docker Experimental Repo Package Groupings
    - _Default:_ `['experimental']`
  - `['apt-nginx']['repos']['docker-experimental']['deb-src']`
    - _Type:_ String
    - _Description:_ Whether or not to add the Docker Experimental Source Repo?
    - _Default:_ `false`
  - `['apt-nginx']['repos']['docker-experimental']['keyserver']`
    - _Type:_ String
    - _Description:_ GPG keyserver for the Docker Experimental Repo
    - _Default:_ `hkp://p80.pool.sks-keyservers.net:80`
  - `['apt-nginx']['repos']['docker-experimental']['key']`
    - _Type:_ String
    - _Description:_ GPG fingerprint for the Docker Experimental Repo
    - _Default:_ `58118E89F3A912897C070ADBF76221572C52609D`

Usage
-----
#### apt-docker::default
Just include `apt-docker` in your node's `run_list`:

```json
{
  "name": "my_node",
  "run_list": [
    "recipe[apt-docker]"
  ]
}
```

Contributing
------------
1. Fork the repository on GitHub
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using GitHub

Development Environment
-------------------
This repository contains a Vagrantfile which can be used to spin up a
fully configured development environment in Vagrant.  

Vagrant requires the following:
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

The Vagrant environment for this repository is based on:
- [st-isidore-de-seville/trusty64-rvm-docker](https://atlas.hashicorp.com/st-isidore-de-seville/boxes/trusty64-rvm-docker)

The Vagrant environment will initialize itself to:
- install required Ruby gems
- run integration testing via kitchen-docker when calling `kitchen`

The Vagrant environment can be spun up by performing the following commands:

1. `vagrant up`
2. `vagrant ssh`
3. `cd /vagrant`

Authors
-------------------
- Author:: St. Isidore de Seville (st.isidore.de.seville@gmail.com)

License
-------------------
```text
The MIT License (MIT)

Copyright (c) 2015 St. Isidore de Seville (st.isidore.de.seville@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
