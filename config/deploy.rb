
require 'bundler/capistrano'

Dir['config/deploy/*.rb'].each { |recipe| load recipe }

ssh_options[:forward_agent] = true

set :application, "junglly"
set :scm, :git
set :repository,  "git@codeplane.com:chsh/junglly.git"

set :user, 'deployer'
set :rails_env, :production
set :keep_releases, 2

task :live do

  set :domain, 'u7.skr.network-servers.net'

  role :app, domain
  role :web, domain
  role :db,  domain, :primary => true

  set :target_name, 'live'
  set :branch,      'master'
  set :deploy_to,   "/apps/#{application}-#{target_name}"
end

set :use_sudo, true

set :ruby_version, '1.9.3-p125'

set :bundle_dir, "/bundles/#{ruby_version}"

default_environment["RUBY_VERSION"] = "ruby-#{ruby_version}"
default_environment["GEM_HOME"]     = "#{bundle_dir}/ruby/1.9.1"
default_environment["PATH"]         = "#{bundle_dir}/bin:/opt/ruby/#{ruby_version}/bin:/usr/pgsql-9.1/bin:$PATH"
default_run_options[:pty] = true

default_environment["LANG"]     = "ja_JP.UTF-8"
default_environment["LC_ALL"]     = "ja_JP.UTF-8"

