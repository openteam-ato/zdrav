require 'openteam/capistrano/deploy'

append :linked_dirs, 'public/video_messages'
append :linked_dirs, 'public/.well-known/acme-challenge'

namespace :sitemap do
  desc 'Create symlink from shared sitemaps to public'
  task :symlink do
    on roles(:app) do
      execute "ln -nfs #{shared_path}/sitemaps/sitemap.xml #{current_path}/public/sitemap.xml"
      execute "ln -nfs #{shared_path}/sitemaps/sitemap.xml.gz #{current_path}/public/sitemap.xml.gz"
    end
  end

  after 'deploy', 'sitemap:symlink'
end

desc 'Download video files'
task :download_video_files do
  on roles(:all) do |host|
    download! "#{shared_path}/public/video_messages", 'public', :via =>:scp, :recursive =>:true
  end
end

set :slackistrano,
  channel: (Settings['slack.channel'] rescue ''),
  webhook: (Settings['slack.webhook'] rescue '')
