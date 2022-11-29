source 'https://rubygems.org'

# Full-stack web application framework. (http://rubyonrails.org)
gem 'rails',                   '5.2.3'
# bootstrap-sass is a Sass-powered version of Bootstrap 3, ready to drop right into your Sass powered applications. (https://github.com/twbs/bootstrap-sass)
gem 'bootstrap-sass',          '~> 3.4.1'
# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications (http://puma.io)
gem 'puma',                    '3.9.1'
# Sass adapter for the Rails asset pipeline. (https://github.com/rails/sass-rails)
gem 'sass-rails',              '>= 5.0.5'
# Ruby wrapper for UglifyJS JavaScript compressor (http://github.com/lautis/uglifier)
gem 'uglifier',                '4.1.20'
# CoffeeScript adapter for the Rails asset pipeline. (https://github.com/rails/coffee-rails)
gem 'coffee-rails',            '5.0.0'
# Use jQuery with Rails 4+ (https://github.com/rails/jquery-rails)
gem 'jquery-rails',            '4.3.1'
# Turbolinks makes navigating your web application faster (https://github.com/turbolinks/turbolinks)
gem 'turbolinks',              '5.0.1'
# Create JSON structures via a Builder-style DSL (https://github.com/rails/jbuilder)
gem 'jbuilder',                '2.7.0'
# OpenBSD's bcrypt() password hashing algorithm. (https://github.com/codahale/bcrypt-ruby)
gem 'bcrypt',                  '3.1.13'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# Embed the V8 JavaScript interpreter into Ruby (http://github.com/cowboyd/therubyracer)
gem 'therubyracer', platforms: :ruby

# テストとDBシードでの仮想データ作成用
# Easily generate fake data (https://github.com/stympy/faker)
gem 'faker',                   '1.7.3'

# 画像アップロード
# Ruby file upload library (https://github.com/carrierwaveuploader/carrierwave)
gem 'carrierwave',             '1.2.2'
# Manipulate images with minimal use of memory via ImageMagick / GraphicsMagick (https://github.com/minimagick/minimagick)
gem 'mini_magick',             '4.7.0'

# ページネーション用
# Pagination plugin for web frameworks and other apps (https://github.com/mislav/will_paginate/wiki)
gem 'will_paginate'
# Format will_paginate html to match Twitter Bootstrap styling. (https://github.com/yrgoldteeth/bootstrap-will_paginate)
gem 'bootstrap-will_paginate'

group :development, :test do
  # This module allows Ruby programs to interface with the SQLite3 database engine (http://www.sqlite.org) (https://github.com/sparklemotion/sqlite3-ruby)
  gem 'sqlite3', '1.3.13'
  # Ruby 2.0 fast debugger - base + CLI (http://github.com/deivid-rodriguez/byebug)
  gem 'byebug',  '11.0.1', platform: :mri
  # RSpec for Rails (https://github.com/rspec/rspec-rails)
  gem 'rspec-rails', '~> 5.1.2'
  # factory_bot_rails provides integration between factory_bot and rails 3 or newer (http://github.com/thoughtbot/factory_bot_rails)
  gem 'factory_bot_rails', '~> 4.10.0'
  # rspec command for spring (https://github.com/jonleighton/spring-commands-rspec)
  gem 'spring-commands-rspec'
end

group :development do
  # A debugging tool for your Ruby on Rails applications. (https://github.com/rails/web-console)
  gem 'web-console',           '3.5.1'
  # Listen to file modifications (https://github.com/guard/listen)
  gem 'listen',                '3.7.1'
  # Rails application preloader (https://github.com/rails/spring)
  gem 'spring',                '2.0.2'
  # Makes spring watch files using the listen gem. (https://github.com/jonleighton/spring-watcher-listen)
  gem 'spring-watcher-listen', '2.0.1'

  # Add comments to your Gemfile with each dependency's description. (https://github.com/ivantsepp/annotate_gem)
  gem 'annotate_gem'
  # Annotates Rails Models, routes, fixtures, and others based on the database schema. (http://github.com/ctran/annotate_models)
  gem 'annotate'
  
  # A Ruby language server (http://solargraph.org)
  gem 'solargraph'
end

group :test do
  # Extracting `assigns` and `assert_template` from ActionDispatch. (https://github.com/rails/rails-controller-testing)
  gem 'rails-controller-testing', '1.0.2'
  # Create customizable Minitest output formats (https://github.com/CapnKernul/minitest-reporters)
  gem 'minitest-reporters',       '1.3.6'
  # Guard keeps an eye on your file modifications (http://guardgem.org)
  gem 'guard',                    '2.15.0'
  # Guard plugin for the Minitest framework (https://rubygems.org/gems/guard-minitest)
  gem 'guard-minitest',           '2.4.4'
  # Capybara aims to simplify the process of integration testing Rack applications, such as Rails, Sinatra or Merb (https://github.com/jnicklas/capybara)
  gem 'capybara',                 '~> 3.25.0'
  # The next generation developer focused tool for automated testing of webapps (https://github.com/SeleniumHQ/selenium)
  gem 'selenium-webdriver'
end

group :production do
  # Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/] (https://bitbucket.org/ged/ruby-pg)
  gem 'pg',  '1.1.4'
  # brings clouds to you (http://github.com/fog/fog)
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
# Timezone Data for TZInfo (http://tzinfo.github.io)
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
