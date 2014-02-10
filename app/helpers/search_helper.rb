module SearchHelper
  def format_summary(content)
    Parser.format_content(content[0..600])
  end

  def format_url(text)
    Formatter.filename_to_url(text)
  end
end