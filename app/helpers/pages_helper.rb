module PagesHelper
  def render_markdown(content)
    Liquid::Template.register_tag('terminal', TerminalTag)
    Liquid::Template.register_tag('irb', IRBTag)
    Liquid::Template.register_tag('exercise', ExerciseTag)

    Liquid::Template.parse(Parser.markdown_to_html(content)).render
  end
end