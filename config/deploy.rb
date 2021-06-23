# config valid for current version and patch releases of Capistrano
# lock "~> 3.11.0"

set :application, 'se_case'
set :repo_url, "git@github.com:vitaliel/se_case.git"
set :user, 'mks'

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/sites/#{fetch(:application)}"
# To upload new changes for puma
# cap production puma:config
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{shared_path}/tmp/sockets/www.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to true if using ActiveRecord
set :puma_env, 'development'

set :rvm_ruby_version, File.read("#{__dir__}/../.ruby-version").strip
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub]

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w[config/database.yml config/master.key .env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets storage config/keys]

namespace :init do
  desc 'Create Directories for Web server Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      # unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #  puts "WARNING: HEAD is not the same as origin/master"
      #  puts "Run `git push` to sync changes."
      #  exit
      # end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  # desc 'Restart application'
  # task :restart do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     execute "sv restart ~/service/#{fetch(:application)}"
  #   end
  # end

  before :starting, :check_revision
  after :finishing, :compile_assets
  after :finishing, :cleanup
  after :finishing, :restart
end
