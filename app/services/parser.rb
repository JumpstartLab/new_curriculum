class Parser
  class HTMLRuby < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def self.markdown_to_html(content)
    renderer = HTMLRuby.new(hard_wrap: true, filter_html: true)
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

  def self.content_between_markers(content, marker1, marker2)
    content[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end
end