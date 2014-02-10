class PageGenerator
  attr_reader :directory

  def initialize(directory)
    @directory = directory
  end

  def generate_pages
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
    Page.pluck(:filename).include?(filename)
  end

  def files
    files = {}

    filenames.each { |filename| files["#{filename}"] = read_file(filename) }

    files
  end

  def filenames
    Dir.foreach(directory).collect { |filename| filename if valid?(filename) }.compact!
  end

  def valid?(filename)
    !filename.start_with?(".", "..")
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

  def generate_title(filename)
    Formatter.filename_to_title(filename)
  end

  def generate_slug(filename)
    Formatter.filename_to_url(filename)
  end
end