require 'openteam/capistrano/deploy'

set :bundle_binstubs, -> { shared_path.join('bin') }

set :linked_dirs, fetch(:linked_dirs) + %w{ public/video_messages }

namespace :sitemap do

  desc 'Create symlink from shared sitemaps to public'
  task :symlink do
    on roles(:app) do
      execute "ln -nfs #{shared_path}/sitemaps/sitemap.xml #{current_path}/public/sitemap.xml"
      execute "ln -nfs #{shared_path}/sitemaps/sitemap.xml.gz #{current_path}/public/sitemap.xml.gz"
    end
  end

  after 'deploy:finishing', 'sitemap:symlink'

end
