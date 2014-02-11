module PagesHelper
  def render_markdown(content)
    Liquid::Template.parse(Parser.markdown_to_html(content)).render
  end
end