# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'auctions'
set :repo_url, 'git@github.com:maripiyoko/auctions.git'
set :branch, ENV.fetch('branch', :master)
set :deploy_to, '/var/www/${fetch(:application)}'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      invoke 'puma:restart'
    end
  end
end
