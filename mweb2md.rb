#!/usr/bin/env ruby
# coding: utf-8

require 'fileutils'
require 'optparse'
require 'optparse/date'
require 'optparse/uri'

Version="0.01"

class MWeb2Md
  ## TODO Should I assgin  MWEB Library from CLI?
  def initialize(options)
    @options = options
    @mweb_doc_path = File.expand_path(options[:lib_path])
    @src_article = File.join(@mweb_doc_path, options[:src_article])
    @article_id = options[:src_article].gsub(/\.md$/, "")
    @src_image_dir = File.join(@mweb_doc_path, "media", @article_id)


    @dest_base_dir = File.expand_path(options[:dest_article_dir])
    @dest_article = File.join(@dest_base_dir, "article.md")
    @dest_image_dir = File.join(@dest_base_dir, "images")

  end

  def convert
    convert_to_markdown
  end

  private
  def convert_to_markdown

    FileUtils.mkdir_p(@dest_base_dir)
    FileUtils.cp(@src_article,  @dest_article + ".bak")
    # media/15024616520518/15059626889397.jpg)こんな感じ
    convert_image_tag("media\/#{@article_id}","images")

    if File.exists?(@src_image_dir)
      FileUtils.mkdir_p(@dest_image_dir)
      copy_images
    end
  end

  def convert_image_tag(pattern, replace)
    text = open(@dest_article + ".bak").read
    replaced = text.gsub(pattern, replace)
    File.open(@dest_article, "w") do |f| f.write(replaced) end
    FileUtils.rm(@dest_article + ".bak")
  end

  def copy_images
    FileUtils.cp_r(Dir.glob("#{@src_image_dir}/*"), @dest_image_dir)
  end
end



def main

  opt = OptionParser.new

  options = {}
  begin
    opt.on('-l MWEBLIBPATH', '--mweb-lib-path=MWEBLIBPATH', "MWeb Library Path") do |v| options[:lib_path] = v end
    opt.on('-s FILENAME', '--src-article=FILENAME', "target markdown file") do |v| options[:src_article] = v end
    opt.on('-d DIR', '--dest-article-dir=DIR', "directory mweb format to general markdown") do |v| options[:dest_article_dir] = v end
    opt.parse(ARGV)
  rescue => e
    puts "ERROR: #{e}.\n See #{opt}"
  end

  converter  = MWeb2Md.new(options)
  converter.convert
end

main
