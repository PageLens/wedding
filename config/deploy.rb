# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'wedding'
set :repo_url, 'git@github.com:PageLens/wedding.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :user, 'deploy'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :postgresql do
  desc 'Alter DB user to superuser'
  task :alter_db_user_to_superuser do
    on roles :db do
      unless psql '-c', %Q{"ALTER user #{fetch(:pg_user)} WITH SUPERUSER;"}
        error 'postgresql: altering database user failed!'
        exit 1
      end
    end
  end
end

namespace :packages do
  desc 'Install packages'
  task :install do
    on roles(:all) do
      with debian_frontend: :noninteractive do
        sudo 'apt-get', 'update'
        sudo 'apt-get', '-y install wget'
        # sudo :echo, '"deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list'
        sudo 'apt-get', 'update'
        sudo 'apt-get', '-y --force-yes install git-core curl python-software-properties ufw postgresql-client libpq-dev build-essential'
      end
    end
  end

  task :install_postgresql do
    on roles(:db) do
      # execute :wget, '-qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -'
      # execute :echo, '"deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list'
      # sudo 'apt-get', 'update'
      sudo 'apt-get', '-y install postgresql postgresql-contrib'
      sudo :sed, %Q{-i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf}
      sudo :sed, '-i "s/host    all             all             127.0.0.1\/32/host    all             all             all/" /etc/postgresql/9.3/main/pg_hba.conf'
      sudo :service, 'postgresql restart'
    end
  end
  after :install, :install_postgresql

  task :install_nginx do
    on roles(:web) do
      # sudo 'add-apt-repository', '-y ppa:nginx/stable'
      # sudo 'apt-get', 'update'
      sudo 'apt-get', '-y install nginx geoip-database'
      execute :wget, 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
      execute :gunzip, 'GeoLiteCity.dat.gz'
      sudo :cp, 'GeoLiteCity.dat /usr/share/GeoIP/'
    end
  end
  after :install, :install_nginx

  task :install_redis do
    on roles(:redis) do
      sudo 'add-apt-repository', '-y ppa:rwky/redis'
      sudo 'apt-get', 'update'
      sudo 'apt-get', 'install -y redis-server'
    end
  end
  # after :install, :install_redis
end

after 'setup', 'puma:nginx_config'
after 'setup', 'puma:config'
after 'postgresql:create_db_user', 'postgresql:alter_db_user_to_superuser'
