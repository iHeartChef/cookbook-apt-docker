source 'https://rubygems.org'

gem 'rake'

# style
gem 'foodcritic'
gem 'rubocop', require: false

# unit
gem 'rspec'
gem 'chefspec'
gem 'berkshelf'

# integration
gem 'serverspec'
gem 'test-kitchen'

group :'local-integration' do
  gem 'kitchen-docker'
  gem 'kitchen-vagrant'
end

group :'ci-integration' do
  gem 'kitchen-docker-api'
end

# publish
gem 'stove'
