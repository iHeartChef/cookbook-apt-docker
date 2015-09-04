require 'spec_helper'

# docker package should be installed when a repository is enabled
describe package('docker-engine') do
  it { should be_installed }
end

# docker package should be installed from the docker-testing repo
describe command('apt-cache madison docker-engine') do
  its(:stdout) { should contain('https://apt.dockerproject.org/repo/') }
  its(:stdout) { should contain('/testing') }
end
