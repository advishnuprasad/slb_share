require 'bundler/capistrano'
require 'capistrano/ext/multistage'
load 'deploy/assets'

set :application, "service_desk"
set :repository,  "git@github.com:advishnuprasad/slb_share.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm, :git

set :scm_username, 'akil_rails'
set :use_sudo, false

set :normalize_asset_timestamps, false

set :stages, ["staging"]
set :default_stage, "staging"
