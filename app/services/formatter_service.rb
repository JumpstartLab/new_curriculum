class FormatterService
  def self.filename_to_title(filename)
    remove_extension(filename).gsub("_", " ").titleize
  end

  def self.filename_to_url(filename)
    "/" + remove_extension(filename)
  end

  def self.remove_extension(filename)
    filename[/[^.]+/]
  end
end