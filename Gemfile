source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'dm_unibo_common',          git: 'https://github.com/donapieppo/dm_unibo_common.git', ref: 'master', branch: 'master'
gem 'dm_unibo_user_search',     git: 'https://github.com/donapieppo/dm_unibo_user_search.git', ref: 'master', branch: 'master'
# gem 'dm_unibo_common',          path: '/home/rails/gems/dm_unibo_common/'
# gem 'dm_unibo_user_search', '= 0.1.1'

gem 'mini_racer', platforms: :ruby

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'pundit'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  #gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  #gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
