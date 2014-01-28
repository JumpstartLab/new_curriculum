class FormatterService
  def self.remove_file_extension(filename)
    filename[/[^.]+/]
  end
end