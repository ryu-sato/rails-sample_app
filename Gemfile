source 'https://rubygems.org'

gem 'rails',                   '5.2.3'
gem 'bootstrap-sass',          '~> 3.4.1'
gem 'puma',                    '3.9.1'
gem 'sass-rails',              '>= 5.0.5'
gem 'uglifier',                '3.2.0'
gem 'coffee-rails',            '4.2.2'
gem 'jquery-rails',            '4.3.1'
gem 'turbolinks',              '5.0.1'
gem 'jbuilder',                '2.7.0'
gem 'bcrypt',                  '3.1.11'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# テストとDBシードでの仮想データ作成用
gem 'faker',                   '1.7.3'

# 画像アップロード
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'

# ページネーション用
gem 'will_paginate'
gem 'bootstrap-will_paginate'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'spring-commands-rspec'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  gem 'capybara',                 '~> 2.8.0'
  gem 'selenium-webdriver'
end

group :production do
  gem 'pg',  '0.18.4'
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
