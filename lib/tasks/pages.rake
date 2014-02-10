namespace :pages do
  desc "generates curriculum pages, and stores them in the database"
  task generate: :environment do
    puts "Generating static pages..."
    PageGenerator.new("app/curriculum").generate_pages
    puts "Done."
  end

  desc "drops the pages table"
  task drop: :environment do
    puts "Dropping static pages table..."
    DatabaseCleaner.clean_with :truncation, { only: ['pages'] }
    puts "Done."
  end

  desc "drops the pages table, and regenerates the content"
  task setup: :environment do
    %w[pages:drop pages:generate].each { |task| Rake::Task[task].invoke }
  end
end