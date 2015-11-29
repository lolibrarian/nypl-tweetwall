source 'https://rubygems.org'

ruby '2.1.6'

gem 'rails', '~> 3.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '0.15.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# For interacting with the Twitter API.
gem "twitter"

# Used to parse HTML documents.
gem "nokogiri"

# A web server.
gem "unicorn"

# A memcached client.
gem "dalli"

# A memcached manager.
gem 'memcachier'

# Used to report errors.
gem "airbrake"

# Used to fetch metadata of remote images.
gem "fastimage"

# Defines a canonical hostname for the application.
gem 'rack-canonical-host'

# Patch OpenURI to allow for HTTP to HTTPS redirections.
gem 'open_uri_redirections', '~> 0.2'

group :development do
  # A debugging console.
  gem 'pry'
  gem 'pry-rails'
end

group :test do
  gem 'minitest', '~> 4.0'
end
