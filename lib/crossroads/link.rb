module Crossroads
  class Link
    include Clearwater::Component

    def initialize(attributes = {}, content = nil, &block)
      @content = content
      @attributes = attributes
      @attributes[:href] ||= attributes.delete(:to)
    end

    def render
      a(@attributes, @content)
    end
  end

end