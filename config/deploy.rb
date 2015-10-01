require 'openteam/capistrano/deploy'

set :bundle_binstubs, -> { shared_path.join('bin') }

namespace :sitemap do

  desc 'Create symlink from shared sitemaps to public'
  task :symlink do
    run "ln -nfs #{shared_path}/sitemaps/sitemap.xml #{current_path}/public/sitemap.xml"
    run "ln -nfs #{shared_path}/sitemaps/sitemap.xml.gz #{current_path}/public/sitemap.xml.gz"
  end

  after 'deploy:finishing', 'sitemap:symlink'

end
