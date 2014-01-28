namespace :index do
  desc "indexes static pages"
  task generate: :environment do
    IndexerService.new("app/views/pages").index_files
  end

  desc "drops the static pages index"
  task drop: :environment do
    DatabaseCleaner.clean_with :truncation, { only: ['static_pages'] }
  end

  desc "drops the index and indexes the pages"
  task setup: :environment do
    %w[index:drop index:generate].each { |task| Rake::Task[task].invoke }
  end
end