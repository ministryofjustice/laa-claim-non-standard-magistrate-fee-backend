source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

gem 'bootsnap', require: false
gem 'dartsass-rails', '~> 0.4.0'
gem 'importmap-rails'
gem 'laa_multi_step_forms', path: 'gems/laa_multi_step_forms'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.3'
gem 'sprockets-rails'
gem 'tzinfo-data'
gem 'uk_postcode'

# Exceptions notifications
gem 'sentry-rails'
gem 'sentry-ruby'

group :development, :test do
  gem 'debug'
  gem 'dotenv-rails'
  gem 'pry'
  gem 'rspec-expectations', '~>3.12.3'
  gem 'rspec-rails'
  gem 'rswag'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'capybara'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov'
  gem 'simplecov-lcov'
  gem 'simplecov-rcov'
  gem 'super_diff'
end
