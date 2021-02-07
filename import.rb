# Based on https://gist.github.com/juniorz/1564581

require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'optionparser'
require 'date'
require 'uri'
require_relative 'src/reverse_markdown_patch'
require_relative 'src/post'
require_relative 'src/comment'

# usage: ruby import.rb my-blog.xml
# my-blog.xml is a file from Settings -> Basic -> Export in blogger.
opts        = OptionParser.new
opts.banner = "Usage: ruby import.rb [-f md|html] [blogger-export-file.xml]\n."

extension = :html
opts.on("-f", "--format [html|markdown]", String, "Creates posts of the format. Default html.") do |f|
  extension = f.downcase == 'html' ? :html : :md
end
opts.parse!
raise opts.banner if ARGV[0].nil?
data = File.read ARGV[0]
doc  = Nokogiri::XML(data)


@posts  = {}
@drafts = {}

def add(node)
  id   = node.search('id').first.content
  type = node
           .search('category')
           .filter('[scheme="http://schemas.google.com/g/2005#kind"]')
           .first
           .attr('term')
           .split('#').last
  case type
  when 'post'
    if published?(node)
      @posts[id] = Post.new(node)
    else
      @drafts[id] = Post.new(node)
    end
  when 'comment'
    reply_to = node.children.find { |c| c.name == 'in-reply-to' }
    post_id  = reply_to.attr('ref')
    #post_id = node.search('thr').first.attr('ref')
    @posts[post_id].add_comment(Comment.new(node))
  when 'template', 'settings', 'page'
  else
    raise 'dunno ' + type
  end
end

def published?(node)
  node.at_css('app|control app|draft', 'app' => 'http://purl.org/atom/app#').nil?
end

def write(post, path, extension)
  puts "Post [#{post.title}] has #{post.comments.count} comments"
  File.open(File.join(path, "#{post.file_name}.#{extension}"), 'w') do |file|
    file.write post.header
    file.write "\n\n"
    #file.write "<h1>{{ page.title }}</h1>\n"
    file.write post.content_as(extension)

    unless post.comments.empty?
      file.write "<h2>Comments</h2>\n"
      file.write "<div class='comments'>\n"
      post.comments.each do |comment|
        file.write "<div class='comment'>\n"
        file.write "<div class='author'>"
        file.write comment.author
        file.write "</div>\n"
        file.write "<div class='content'>\n"
        file.write comment.content_as(extension)
        file.write "</div>\n"
        file.write "</div>\n"
      end
      file.write "</div>\n"
    end

  end
end

entries = {}

doc.search('entry').each do |entry|
  add entry
end

puts "** Writing PUBLISHED posts"
FileUtils.rm_rf('_posts')
Dir.mkdir("_posts") unless File.directory?("_posts")

@posts.each do |id, post|
  write post, '_posts', extension
end

puts "\n"
puts "** Writing DRAFT posts"

FileUtils.rm_rf('_drafts')
Dir.mkdir("_drafts") unless File.directory?("_drafts")

@drafts.each do |id, post|
  write post, '_drafts', extension
end
