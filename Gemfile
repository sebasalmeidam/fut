source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use sqlite3 as the database for Active Record

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'whenever', :require => false
gem 'bootstrap-social-rails'
gem 'font-awesome-rails'
gem 'rails-i18n'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'will_paginate', '~> 3.1.0'
gem 'figaro'
gem 'mechanize', '~> 2.7', '>= 2.7.5'
gem 'puma'
gem 'devise'
gem 'pry-rails', :group => :development
gem 'react-rails', '~> 1.0'
gem 'autonumeric-rails'
gem "chartkick"
gem 'will_paginate-bootstrap'
gem 'jquery-turbolinks'

gem 'linefit', '~> 0.3.3'
gem 'descriptive_statistics', '~> 2.4.0', :require => 'descriptive_statistics/safe'

#api
#gem 'sabisu_rails', github: "IcaliaLabs/sabisu-rails"
#gem "compass-rails", github: "Compass/compass-rails", branch: "master"
#gem 'furatto'
#gem 'font-awesome-rails'
#gem 'simple_form'
gem 'active_model_serializers', '0.8.3'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'sqlite3'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  #gem 'mysql2', '~> 0.3.18'
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'

end



