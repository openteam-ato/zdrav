require 'openteam/capistrano/deploy'

set :bundle_binstubs, -> { shared_path.join('bin') }
