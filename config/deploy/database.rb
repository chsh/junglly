
before 'deploy:assets:precompile', 'db:symlink'

namespace :db do

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end
end

