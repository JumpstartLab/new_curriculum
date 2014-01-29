class IndexerService
  attr_reader :directory,
              :files,
              :parser

  def initialize(directory)
    @directory = directory
    @parser    = ParserService.new
  end

  def index_files
    read_files
    store_files
  end

  def filenames
    Dir.foreach(directory).collect { |filename| filename if valid?(filename) }.compact!
  end

  def read_files
    files = {}

    filenames.each do |filename|
      content = read_file(filename)
      html    = parser.parse_markdown(content)

      files["#{filename}"] = parser.strip_html(html)
    end

    @files = files
  end

  def store_files
    files.each do |filename, content|
      store_file(
        title:    generate_title(filename),
        filename: filename,
        content:  content
        )

      print "."
    end

    puts "\n"
  end

  private

  def read_file(filename)
    File.open("#{directory}/#{filename}").read
  end

  def store_file(attributes)
    StaticPage.create(
      title:    attributes[:title],
      filename: attributes[:filename],
      content:  attributes[:content]
      )
  end

  def generate_title(filename)
    FormatterService.filename_to_title(filename)
  end

  def valid?(filename)
    !filename.start_with?(".", "..")
  end
end