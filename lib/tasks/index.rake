namespace :index do
  desc "indexes static pages"
  task pages: :environment do
    IndexerService.new("app/views/pages").index_files
  end
end