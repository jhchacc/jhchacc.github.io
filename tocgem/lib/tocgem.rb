require "jekyll"
require "html/pipeline"

# Custom Processor

# module Jekyll
#   class Jekyll::Converters::Markdown::MyCustomProcessor
#     def initialize(config)
#       require 'funky_markdown'
#       @config = config
#     rescue LoadError
#       STDERR.puts 'You are missing a library required for Markdown. Please run:'
#       STDERR.puts '  $ [sudo] gem install funky_markdown'
#       raise FatalException.new("Missing dependency: funky_markdown")
#     end

#     def convert(content)
#       ::FunkyMarkdown.new(content).convert
#     end
#   end

#   module Converters
#       class Markdown::MyCustomProcessor
#         def initialize(config)
#           require 'funky_markdown'
#           @config = config
#         rescue LoadError
#           STDERR.puts 'You are missing a library required for Markdown. Please run:'
#           STDERR.puts '  $ [sudo] gem install funky_markdown'
#           raise FatalException.new("Missing dependency: funky_markdown")
#         end

#         def convert(content)
#           ::FunkyMarkdown.new(content).convert
#         end
#       end
#   end
# end

module Jekyll
  class Testify
    class << self
      def puts_for_debug(doc)
        puts doc
        # doc.output = "A"
      end
    end
  end
end

Jekyll::Hooks.register :pages, :post_render do |page|
  # https://github.com/jekyll/jekyll/blob/master/lib/jekyll/page.rb#L8
  page.output =  if page.html?
    '<link rel="stylesheet" href="/assets/css/style.css"><div class="markdown-body"><h1>This is HTML</h1>By Jekyll::Hooks.register :pages, :post_render - output<br></div>'
  else
    page.output
  end
end


# Jekyll::Hooks.register :posts, :post_render do |doc|
#   puts "Jekyll::Hooks.register :posts, :post_render"
#   Jekyll::Testify.puts_for_debug(doc)
#   doc.output="A"
#   doc.content="A"
# end

# Jekyll::Hooks.register :site, :after_init do |doc|
#   puts "Jekyll::Hooks.register :site, :after_init"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :site, :after_reset do |doc|
#   puts "Jekyll::Hooks.register :site, :after_reset"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :site, :post_read do |doc|
#   puts "Jekyll::Hooks.register :site, :post_read"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :site, :pre_render do |doc|
#   puts "Jekyll::Hooks.register :site, :pre_render"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :site, :post_render do |doc|
#   puts "Jekyll::Hooks.register :site, :post_render"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :site, :post_write do |doc|
#   puts "Jekyll::Hooks.register :site, :post_write"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :pages, :post_init do |doc|
#   puts "Jekyll::Hooks.register :pages, :post_init"
#   Jekyll::Testify.puts_for_debug(doc)
# end

# Jekyll::Hooks.register :pages, :pre_render do |doc|
#   puts "Jekyll::Hooks.register :pages, :pre_render"
#   Jekyll::Testify.puts_for_debug(doc)
#   # doc.output = if doc.html?
#   #   "\<This is HTML\><br>"
#   # else
#   #   doc.output
#   # end
# end

# Jekyll::Hooks.register :pages, :post_write do |doc, output|
#   puts "Jekyll::Hooks.register :pages, :post_write"
#   doc.content = "A"
#   doc.output = "A"
#   # return doc
#   # Jekyll::Testify.puts_for_debug(doc)
#   # Jekyll::Testify.puts_for_debug(output)
#   # return output
# end

# # # Jekyll::Hooks.register :posts, :post_init do |doc|
# # #   puts "Jekyll::Hooks.register :posts, :post_init"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :posts, :pre_render do |doc|
# # #   puts "Jekyll::Hooks.register :posts, :pre_render"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :posts, :post_render do |doc|
# # #   puts "Jekyll::Hooks.register :posts, :post_render"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :posts, :post_write do |doc|
# # #   puts "Jekyll::Hooks.register :posts, :post_write"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :documents, :post_init do |doc|
# # #   puts "Jekyll::Hooks.register :documents, :post_init"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :documents, :pre_render do |doc|
# # #   puts "Jekyll::Hooks.register :documents, :pre_render"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :documents, :post_render do |doc|
# # #   puts "Jekyll::Hooks.register :documents, :post_render"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :documents, :post_write do |doc|
# # #   puts "Jekyll::Hooks.register :documents, :post_write"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end

# # # Jekyll::Hooks.register :clean, :on_obsolete do |doc|
# # #   puts "Jekyll::Hooks.register :clean, :on_obsolete"
# # #   Jekyll::Testify.puts_for_debug(doc)
# # # end
