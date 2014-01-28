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
    files.each do |title, content|
      store_file(title: title, content: content)

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
      title:   attributes[:title],
      content: attributes[:content]
      )
  end

  def valid?(filename)
    !filename.start_with?(".", "..")
  end
end