# Based on https://gist.github.com/juniorz/1564581

require 'rubygems'
require 'nokogiri'
require 'fileutils'
require 'date'
require 'uri'

# usage: ruby import.rb my-blog.xml
# my-blog.xml is a file from Settings -> Basic -> Export in blogger.

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

def write(post, path)
  puts "Post [#{post.title}] has #{post.comments.count} comments"
  File.open(File.join(path, post.file_name), 'w') do |file|
    file.write post.header
    file.write "\n\n"
    #file.write "<h1>{{ page.title }}</h1>\n"
    file.write "<div class='post'>\n"
    file.write post.content
    file.write "</div>\n"

    unless post.comments.empty?
      file.write "<h2>Comments</h2>\n"
      file.write "<div class='comments'>\n"
      post.comments.each do |comment|
        file.write "<div class='comment'>\n"
        file.write "<div class='author'>"
        file.write comment.author
        file.write "</div>\n"
        file.write "<div class='content'>\n"
        file.write comment.content
        file.write "</div>\n"
        file.write "</div>\n"
      end
      file.write "</div>\n"
    end

  end
end

class Post
  attr_reader :comments

  def initialize(node)
    @node     = node
    @comments = []
  end

  def add_comment(comment)
    @comments.unshift comment
  end

  def title
    @title ||= @node.at_css('title').content
  end

  def content
    @content ||= @node.at_css('content').content
  end

  def creation_date
    @creation_date ||= creation_datetime.strftime("%Y-%m-%d")
  end

  def creation_datetime
    @creation_datetime ||= Date.parse(@node.search('published').first.content)
  end

  #     <link rel='alternate' type='text/html' href='https://blog.ndpsoftware.com/2006/03/we-posted-on-craigslist.html'
  #<link rel='alternate' type='text/html'
  # href='https://blog.ndpsoftware.com/2017/02/test-pantry-test-data-factory.html'
  # title='Introducing Test Pantry'/>
  def permalink
    return @permalink unless @permalink.nil?

    link_node  = @node.at_css('link[rel=alternate]')
    @permalink = link_node && link_node.attr('href')
  end

  def param_name
    if permalink.nil?
      title.split(/[^a-zA-Z0-9]+/).join('-').downcase
    else
      File.basename(URI(permalink).path, '.*')
    end
  end

  def permalink_path
    if permalink.nil?
      "/#{creation_datetime.year}/#{creation_datetime.month.to_s.rjust(2,'0')}/#{param_name}.html"
    else
      permalink.gsub(/^https?:\/\/[^\/]+/, '')
    end
  end

  def file_name
    %{#{creation_date}-#{param_name}.html}
    # permalink.split('/').last
  end

  def header
    [
      '---',
      %{layout: post},
      %{title: "#{title}"},
      %{date: #{creation_datetime}},
      %{comments: false},
      %{url: #{permalink_path}},
      tags,
      '---'
    ].compact.join("\n")
  end

  def categories
    terms = @node.search('category[scheme="http://www.blogger.com/atom/ns#"]')
    unless Array(terms).empty?
      [
        'categories:',
        terms.map { |t| t.attr('term') && " - #{t.attr('term')}" }.compact.join("\n"),
      ].join("\n")
    end
  end

  def tags
    terms = @node.search('category[scheme="http://www.blogger.com/atom/ns#"]')
    unless Array(terms).empty?
      [
        'tags:',
        terms.map { |t| t.attr('term') && " - #{t.attr('term')}" }.compact.join("\n"),
      ].join("\n")
    end
  end
end

class Comment
  def initialize(node)
    @node = node
  end

  def author
    @node.search('author name').first.content
  end

  def content
    @node.search('content').first.content
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
  write post, '_posts'
end

puts "\n"
puts "** Writing DRAFT posts"

FileUtils.rm_rf('_drafts')
Dir.mkdir("_drafts") unless File.directory?("_drafts")

@drafts.each do |id, post|
  write post, '_drafts'
end
