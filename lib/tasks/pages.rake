namespace :pages do
  desc "indexes static pages"
  task generate: :environment do
    puts "parses static pages and stores them into database"
    PageGenerator.new("app/curriculum").generate_pages
    puts "Done."
  end

  desc "drops the static pages table"
  task drop: :environment do
    puts "Dropping static pages table"
    DatabaseCleaner.clean_with :truncation, { only: ['pages'] }
    puts "Done."
  end

  desc "regenerates static pages data"
  task setup: :environment do
    %w[pages:drop pages:generate].each { |task| Rake::Task[task].invoke }
  end
end