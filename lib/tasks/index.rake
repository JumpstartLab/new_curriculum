namespace :index do
  desc "indexes static pages"
  task generate: :environment do
    puts "Generating static pages index..."
    IndexerService.new("app/views/pages").index_files
    puts "Done."
  end

  desc "drops the static pages index"
  task drop: :environment do
    puts "Dropping static pages index..."
    DatabaseCleaner.clean_with :truncation, { only: ['static_pages'] }
    puts "Done."
  end

  desc "drops the index and indexes the pages"
  task setup: :environment do
    %w[index:drop index:generate].each { |task| Rake::Task[task].invoke }
  end
end