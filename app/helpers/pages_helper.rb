module PagesHelper
  def render_markdown(content)
    Parser.markdown_to_html(content)
  end
end