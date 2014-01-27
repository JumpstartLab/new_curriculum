class IndexerService
  attr_reader :directory,
              :files

  def initialize(directory)
    @directory = directory
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
      file = read_file(filename)
      html = parse_markdown(file)

      files["#{filename}"] = strip_html(html)
    end

    @files = files
  end

  def store_files
    files.each do |title, content|
      StaticPage.create(
        title:   title,
        content: content
        )
    end
  end

  def read_file(filename)
    File.open("#{directory}/#{filename}").read
  end

  def parse_markdown(file)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    options  = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
      lax_html_blocks:    true,
      strikethrough:      true,
      superscript:        true
    }

    Redcarpet::Markdown.new(renderer, options).render(file).html_safe
  end

  def strip_html(html)
    ActionView::Base.full_sanitizer.sanitize(html)
  end

  private

  def valid?(filename)
    filename.start_with?(".", "..") ? false : true
  end
end