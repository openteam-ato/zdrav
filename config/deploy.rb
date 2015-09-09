require 'openteam/capistrano/deploy'

set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }
