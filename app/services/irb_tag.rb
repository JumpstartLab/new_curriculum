class IRBTag < Liquid::Block
  attr_reader :window_type

  def initialize(tag_name, markup, tokens)
    @window_type = tag_name
    super
  end

  def render(context)
    output = super(context)

    %{<div class="window">
        <nav class="control-window">
          <a href="#finder" class="close_window" data-rel="close">close</a>
          <a href="#" class="minimize">minimize</a>
          <a href="#" class="deactivate">deactivate</a>
        </nav>
        <h1 class="titleInside">#{title}</h1>
        <div class="container_window"><div class="#{window_type}">#{format(output)}</div></div>
      </div>}
  end

  def title
    window_type.upcase
  end

  def format(output)
    irbize(output)
  end

  def irbize(str)
    table = '<table><tr><td class="gutter"><pre class="line-numbers">'
    code = ''

    index = 0

    str.strip.lines.each do |line|
      if line.start_with? "$"
        index += 1
        line  = line.gsub("$","").strip
        table += "<span class='line-number'>2.1.0 :#{index.to_s.rjust(3,'0')}&gt;</span>\n"
        code  += "<span class='line command'>#{line.strip}</span>"
      else
        table += "<span class='line-number'>&nbsp;</span>\n"
        code  += "<span class='line output'>#{line.strip}</span>"
      end
    end
    table += "</pre></td><td class='code'><pre><code>#{code}</code></pre></td></tr></table>"
  end
end