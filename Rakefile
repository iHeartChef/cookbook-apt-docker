require 'foodcritic'
require 'kitchen'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'stove/rake_task'

# Style tests
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:foodcritic)
end

desc 'Run all style checks'
task style: ['style:rubocop', 'style:foodcritic']

# Unit tests
namespace :unit do
  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:spec)
end

desc 'Run all unit tests'
task unit: ['unit:spec']

# Integration tests
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Test Kitchen with Docker'
  task :docker do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.docker.yml')
    config = Kitchen::Config.new(loader: @loader)
    config.instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Run all integration tests'
task integration: ['integration:vagrant', 'integration:docker']

# Publish
Stove::RakeTask.new do |t|
  t.stove_opts = ['--extended-metadata']
end

# Default
task default: %w(style unit)

# All tasks
task all: %w(style unit integration)
