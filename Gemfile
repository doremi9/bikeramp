source 'https://rubygems.org'
git_source(:github) { |_repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'activeadmin'
gem 'bootstrap', '~> 4.1.3'
gem 'carrierwave'
gem 'devise'
gem 'fog-aws'
gem 'geocoder'
gem 'grape'
gem 'jquery-rails'
gem 'jwt'
gem 'mini_magick'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pdf-inspector', require: "pdf/inspector"
gem 'prawn'
gem 'prawn-table'
gem 'puma', '~> 4.3'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.0'
gem 'money-rails'
gem 'virtus'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry'
end

group :development do
  # Capistrano gems
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'

  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'timecop'
end
