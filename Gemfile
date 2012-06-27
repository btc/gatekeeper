source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'thin'

gem 'pg'

gem 'rspec-rails', :group => [:test, :development]

gem 'guard-spork', :group => [:test, :development]

gem 'factory_girl_rails', :group => [:test, :development]

group :test do
  gem 'capybara'
  gem 'guard-rspec'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  # This gem is only needed in this group as it’s onliy used by the assets
  # pipeline. If we’re using static assets in production then it won’t be
  # needed.
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

gem 'haml-rails'

gem 'simple_form'

gem 'devise'
gem 'cancan'
