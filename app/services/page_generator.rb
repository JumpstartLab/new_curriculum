class PageGenerator
  attr_reader :directory,
              :files

  def initialize(directory)
    @directory = directory
    @parser    = Parser.new
  end

  def generate_pages
    read_files
    store_files
  end

  def filenames
    Dir.foreach(directory).collect { |filename| filename if valid?(filename) }.compact!
  end

  def read_files
    files = {}

    filenames.each { |filename| files["#{filename}"] = read_file(filename) }

    @files = files
  end

  def store_files
    files.each do |filename, content|
      unless file_exists?(filename)
        store_file(
          title:    generate_title(filename),
          filename: filename,
          content:  content,
          slug:     generate_slug(filename)
          )

        print "."
      end
    end

    puts "\n"
  end

  private

  def file_exists?(filename)
    Page.all.map(&:filename).include?(filename)
  end

  def read_file(filename)
    File.open("#{directory}/#{filename}").read
  end

  def store_file(attributes)
    Page.create(
      title:    attributes[:title],
      filename: attributes[:filename],
      content:  attributes[:content],
      slug:     attributes[:slug]
      )
  end

  def generate_slug(filename)
    Formatter.filename_to_url(filename)
  end

  def generate_title(filename)
    Formatter.filename_to_title(filename)
  end

  def valid?(filename)
    !filename.start_with?(".", "..")
  end
end