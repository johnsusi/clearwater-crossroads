module Crossroads
  class Miss
    include Clearwater::Component

    def initialize(attributes = {}, component: nil, render: nil, &block)
      @attributes = attributes
      # @attributes[:key] ||= 'miss'
      @render = -> { component.new } if component
      @render = render if render
      @render = block if block
    end

    def render
      div(@attributes, [@render.call()]) if !Router.matched.last
    end
  end
end