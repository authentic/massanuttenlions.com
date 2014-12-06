# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'massanuttenlions'
set :repo_url, 'git://github.com/authentic/massanuttenlions.com.git'
set :deploy_user, 'massanut'
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/massanut/massanuttenlions'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
 set :linked_files, %w{config/database.yml config/.google-api.yaml}
 set :linked_dirs, %w(ckeditor_assets paperclip_assets log)


# desc "Symlinks the database.yml, .google-api.yaml, ckeditor_assets and paperclip_assets folders"
# task :symlink_config_shared do
#   on roles(:app) do
#     execute "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#     execute "ln -nfs #{shared_path}/config/.google-api.yaml #{release_path}/.google-api.yaml"
#     execute "ln -s #{shared_path}/ckeditor_assets #{release_path}/public/ckeditor_assets"
#     execute "ln -s #{shared_path}/paperclip_assets #{release_path}/public/paperclip_assets"
#   end
# end



# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :finishing, 'linked_files:upload'
  after :finishing, 'deploy:cleanup'

end




# desc "Creates the production log if it does not exist"
# task :create_production_log do
#   unless File.exist?(File.join(shared_path, 'log', 'production.log'))
#     puts "\n\n=== Creating Production Log! ===\n\n"
#     run "touch #{File.join(shared_path, 'log', 'production.log')}"
#   end
# end
#after 'deploy:update_code', 'create_production_log'
