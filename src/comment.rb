require_relative 'post_or_comment'

class Comment < PostOrComment
  def author
    @node.search('author name').first.content
  end

  def content
    @node.search('content').first.content
  end
end
