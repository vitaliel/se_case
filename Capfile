require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/bundler'
require "capistrano/rvm"
require 'capistrano/rails/assets'
require 'capistrano/puma'
require "capistrano/scm/git"

install_plugin Capistrano::SCM::Git
install_plugin Capistrano::Puma

# Include tasks from other gems included in your Gemfile
require "capistrano/rails/migrations"

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
