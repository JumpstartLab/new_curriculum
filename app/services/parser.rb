class Parser
  def self.markdown_to_html(content)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    options  = {
      autolink:           true,
      no_intra_emphasis:  true,
      fenced_code_blocks: true,
      lax_html_blocks:    true,
      strikethrough:      true,
      superscript:        true
    }

    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  def self.strip_html(html)
    ActionView::Base.full_sanitizer.sanitize(html)
  end

  def self.format_content(content)
    html = markdown_to_html(content)
    strip_html(html).gsub(/[^\p{Alnum}\p{Punct}]/, ' ')
  end
end