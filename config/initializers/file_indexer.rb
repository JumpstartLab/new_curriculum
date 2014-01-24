class FileIndexer
  attr_reader :directory

  def initialize(directory)
    @directory = directory
  end

  def index_files
    filenames
    read_files
  end

  def filenames
    Dir.foreach(directory).collect { |filename| filename if valid?(filename) }.compact!
  end

  def read_files
    files = {}

    filenames.each do |filename|
      files["#{filename}"] = File.open("#{directory}/#{filename}").read
    end

    files
  end

  private

  def valid?(filename)
    filename.start_with?(".", "..") ? false : true
  end
end