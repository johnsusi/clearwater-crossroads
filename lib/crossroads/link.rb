module Crossroads
  class Link
    include Clearwater::Component

    def initialize(attributes = {}, content = nil, &block)
      @content = content
      @block = block
      @attributes = attributes
      @attributes[:href] ||= attributes.delete(:to)
      @attributes[:onclick] = -> (event) {
        event.prevent
        $$.window.history.pushState({}, '', @attributes[:href])
        self.call
      }
    end

    def render
      a(@attributes, @content || @block.call)
    end
  end

  def link(to, &block)
    Link.new(to: to, &block)
  end

  module_function :link
end