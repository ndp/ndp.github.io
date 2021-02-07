require 'reverse_markdown'

# My blog has some funkily configured code
# https://github.com/xijo/reverse_markdown/wiki/Write-your-own-converter

class CodeBlock < ReverseMarkdown::Converters::Base
  def convert(node, state = {})
    style = node.attribute('style')
    if /font-family:.*courier.*monospace/ =~ style ||
      (/white-space: pre-wrap/ =~ style &&
        /font-family: .*source code pro/ =~ style)
      "`#{node.text}`"
    else
      treat_children(node, state)
    end
  end
end

ReverseMarkdown::Converters.register :span, CodeBlock.new
