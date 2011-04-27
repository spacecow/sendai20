default_run_options[:pty] = true
set :repository,  "git@github.com:spacecow/sendai20.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false

set :application, "sendai20"
set :deploy_to, "/home/aurora/apps/#{application}"
set :user, "aurora"
set :admin_runner, "aurora"
  
role :app, "sao.fir-vpc.riec.tohoku.ac.jp"
role :web, "sao.fir-vpc.riec.tohoku.ac.jp"
role :db,  "sao.fir-vpc.riec.tohoku.ac.jp", :primary => true

set :rake, "~/.rvm/rubies/ruby-1.9.2-head/bin/rake"
set :default_environment, { 
  'PATH' => "/home/aurora/.rvm/rubies/ruby-1.9.2-head/bin:/home/aurora/.rvm/gems/ruby-1.9.2-head/bin:/home/aurora/.rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby 1.9.2',
  'GEM_HOME' => '/home/aurora/.rvm/gems/ruby-1.9.2-head',
  'GEM_PATH' => '/home/aurora/.rvm/gems/ruby-1.9.2-head' 
}


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
