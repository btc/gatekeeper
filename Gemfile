source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'thin'

gem 'pg'

gem 'rspec-rails', :group => [:test, :development]

group :development do
  gem 'ruby_gntp'                         # notifications (growl)
  gem 'guard-livereload'                  # must install browser extension
  gem 'guard-rails'                       # run rails server through guard
end

gem 'guard-spork', :group => [:test, :development]

group :test do
  gem 'capybara'                          # simulate UX in tests
  gem 'guard-rspec'                       # run continuous* tests
  gem 'shoulda-matchers'                  # useful test methods
  gem 'factory_girl_rails'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'

  # This gem is only needed in this group as it’s onliy used by the assets
  # pipeline. If we’re using static assets in production then it won’t be
  # needed.
end

gem 'twitter-bootstrap-rails'
gem 'jquery-rails'

gem 'haml-rails'

gem 'simple_form'

gem 'devise'
gem 'cancan'

gem 'coffee-filter'

gem 'paperclip'

gem 'cocoon'

gem 'birthday'                            # ActiveRecord::Base scopes
gem 'chronic'                             # NL parsing of Dates

gem 'capistrano'
gem 'unicorn'

gem 'paper_trail'

gem 'best_in_place'

gem 'jquery-ui-rails'
gem 'acts-as-taggable-on'
gem 'rails3-jquery-autocomplete'

gem 'will_paginate'
gem 'will_paginate-bootstrap'

gem 'text'

gem 'rb-fsevent', '~> 0.9.1'
