namespace :index do
  desc "indexes static pages"
  task pages: :environment do
    IndexerService.new("app/views/pages").index_files
  end

  desc "drops the static pages index"
  task drop: :environment do
    StaticPage.destroy_all
  end

  desc "drops the index and indexes the pages"
  task setup: :environment do
    %w[index:drop index:pages].each { |task| Rake::Task[task].invoke }
  end
end