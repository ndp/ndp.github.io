require_relative 'post_or_comment'

class Post < PostOrComment
  attr_reader :comments

  def initialize(node)
    super
    @comments = []
  end

  def add_comment(comment)
    @comments.unshift comment
  end

  def title
    @title ||= @node.at_css('title').content
  end

  def content
    @node.at_css('content').content
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
      "/#{creation_datetime.year}/#{creation_datetime.month.to_s.rjust(2, '0')}/#{param_name}.html"
    else
      permalink.gsub(/^https?:\/\/[^\/]+/, '')
    end
  end

  def file_name
    %{#{creation_date}-#{param_name}}
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
      %{permalink: #{permalink_path}},
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
