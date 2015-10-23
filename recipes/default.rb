#
# Cookbook Name:: apt-docker
# Recipe:: default
#
#  Installs & configures the apt Docker repostories.  Any attribute supported by
#  the [apt cookbook](https://github.com/chef-cookbooks/apt#parameters) is
#  supported by this cookbook and can be used to override attributes in this
#  cookbook.

# check if platform is supported
platform_family = node['platform_family']
platform = node['platform']
platform_version = node['platform_version']

fail("#{platform_family}/#{platform}/#{platform_version} is not supported by the default recipe") \
 unless platform_family?('debian') &&
        node['apt-docker']['supported-codenames']
        .select { |_version, is_included| is_included }
        .keys
        .include?(node['lsb']['codename'])

node['apt-docker']['repos'].each do |repo, value|
  apt_repository repo do
    # define all attributes even though we are not using them all so that the
    #  values can be passed through to override apt repository definitions

    # Attribute Sources:
    #  https://github.com/opscode-cookbooks/apt
    #  https://github.com/opscode-cookbooks/apt/blob/master/resources/repository.rb

    repo_name value['repo_name'] if value['repo_name']
    uri value['uri'] if value['uri']
    distribution value['distribution'] if value['distribution']
    components value['components'] if value['components']
    arch value['arch'] if value['arch']
    trusted value['trusted'] if value['trusted']
    deb_src value['deb-src'] if  value['deb-src']
    keyserver value['keyserver'] if value['keyserver']
    key value['key'] if value['key']
    key_proxy value['key_proxy'] if value['key_proxy']
    cookbook value['cookbook'] if value['cookbook']
    cache_rebuild value['cache_rebuild'] if value['cache_rebuild']
  end if value['managed']
end
