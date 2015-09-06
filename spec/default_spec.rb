require 'spec_helper'

platform_test_matrix = {
  debian: {
    '7.1': 'wheezy',
    '8.1': 'jessie'
  },
  ubuntu: {
    '12.04': 'precise',
    '14.04': 'trusty',
    '14.10': 'utopic',
    '15.04': 'vivid',
    '15.10': 'wily'
  }
}

describe 'apt-docker' do
  platform_test_matrix.each do |platform, versions|
    versions.each do |version, codename|
      describe "when on #{platform} #{version}" do
        context 'by default' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform.to_s, version: version.to_s)
              .converge(described_recipe)
          end

          it 'should create the docker-main repo with default attribs' do
            expect(chef_run).to add_apt_repository('docker-main').with(
              uri: 'https://apt.dockerproject.org/repo',
              distribution: "#{platform}-#{codename}",
              components: ['main'],
              deb_src: false,
              keyserver: 'hkp://p80.pool.sks-keyservers.net:80',
              key: '58118E89F3A912897C070ADBF76221572C52609D'
            )
          end

          it 'should not create the docker-testing repo' do
            expect(chef_run).to_not add_apt_repository('docker-testing')
          end

          it 'should not create the docker-experimental repo' do
            expect(chef_run).to_not add_apt_repository('docker-experimental')
          end
        end

        context 'when only docker-testing is managed' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform.to_s, version: version.to_s) do |node|
              node.set['apt-docker']['repos']['docker-main']['managed'] = false
              node.set['apt-docker']['repos']['docker-testing']['managed'] = true
              node.set['apt-docker']['repos']['docker-experimental']['managed'] = false
            end.converge(described_recipe)
          end

          it 'should not create the docker-main repo' do
            expect(chef_run).to_not add_apt_repository('docker-main')
          end

          it 'should create the docker-testing repo with default attribs' do
            expect(chef_run).to add_apt_repository('docker-testing').with(
              uri: 'https://apt.dockerproject.org/repo',
              distribution: "#{platform}-#{codename}",
              components: ['testing'],
              deb_src: false,
              keyserver: 'hkp://p80.pool.sks-keyservers.net:80',
              key: '58118E89F3A912897C070ADBF76221572C52609D'
            )
          end

          it 'should not create the docker-experimental repo' do
            expect(chef_run).to_not add_apt_repository('docker-experimental')
          end
        end

        context 'when only docker-experimental is managed' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform.to_s, version: version.to_s) do |node|
              node.set['apt-docker']['repos']['docker-main']['managed'] = false
              node.set['apt-docker']['repos']['docker-testing']['managed'] = false
              node.set['apt-docker']['repos']['docker-experimental']['managed'] = true
            end.converge(described_recipe)
          end

          it 'should not create the docker-main repo' do
            expect(chef_run).to_not add_apt_repository('docker-main')
          end

          it 'should not create the docker-testing repo' do
            expect(chef_run).to_not add_apt_repository('docker-testing')
          end

          it 'should create the docker-experimental repo with default attribs' do
            expect(chef_run).to add_apt_repository('docker-experimental').with(
              uri: 'https://apt.dockerproject.org/repo',
              distribution: "#{platform}-#{codename}",
              components: ['experimental'],
              deb_src: false,
              keyserver: 'hkp://p80.pool.sks-keyservers.net:80',
              key: '58118E89F3A912897C070ADBF76221572C52609D'
            )
          end
        end

        describe 'when adding a custom docker repo' do
          let(:chef_run) do
            ChefSpec::SoloRunner.new(platform: platform.to_s, version: version.to_s) do |node|
              node.set['apt-docker']['repos']['docker-new']['managed'] = true
              node.set['apt-docker']['repos']['docker-new']['uri'] = 'http://path.to.docker'
              node.set['apt-docker']['repos']['docker-new']['components'] = ['new']
              node.set['apt-docker']['repos']['docker-new']['deb_src'] = false
              node.set['apt-docker']['repos']['docker-new']['keyserver'] = 'hkp://path.to.docker'
              node.set['apt-docker']['repos']['docker-new']['key'] = '0123456789'
            end.converge(described_recipe)
          end

          it 'should create the docker-new repo' do
            expect(chef_run).to add_apt_repository('docker-new').with(
              uri: 'http://path.to.docker',
              components: ['new'],
              deb_src: false,
              keyserver: 'hkp://path.to.docker',
              key: '0123456789'
            )
          end
        end
      end
    end
  end

  context 'when on an unsupported platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'redhat', version: '7.0')
        .converge(described_recipe)
    end

    it 'should raise an error' do
      expect { chef_run }.to raise_error('rhel/redhat/7.0 is not supported by the default recipe')
    end
  end
end
