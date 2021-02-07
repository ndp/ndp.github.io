
class PostOrComment
  def initialize(node)
    @node = node
  end

  def content_as(extension)
    extension == :md ? content_as_md : content_as_html
  end

  def content_as_md
    ReverseMarkdown.convert(content, unknown_tags: :pass_through, github_flavored: true)
  end

  def content_as_html
    "<div class='post'>\n#{content}</div>\n"
  end

end
