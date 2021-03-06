require "bundler/capistrano"

set :application, "p2p_book_sharing"

# Setup for SCM(Git)
set :scm, :git
set :repository, "git@github.com:onesup/p2p_book_sharing.git"
set :branch, "master"

role :web, "14.63.196.19"     # Your HTTP server, Apache/etc
role :app, "14.63.196.19"     # This may be the same as your `Web` server
role :db,  "14.63.196.19", :primary => true # This is where Rails migrations will run

set :user, "moncl"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :default_environment, { "PATH" =>
"$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/versions/1.9.3-p286/bin:$HOME/.rbenv/versions/1.9.3-p286/lib/ruby/gems/1.9.1/gems:$PATH"
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  desc "expand the gems"
  task :gems, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path}; #{shared_path}/bin/bundle unlock"
    run "cd #{current_path}; nice -19 #{shared_path}/bin/bundle install vendor/" # nice -19 is very important otherwise DH will kill the process!
    run "cd #{current_path}; #{shared_path}/bin/bundle lock"
  end
    
  # task :symlink_config, roles: :app do
  #   run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  # end
  # after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end