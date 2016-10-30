module Crossroads
  class Router
    include Clearwater::Component

    def initialize(attributes = {}, component: nil, render: nil, &block)
      @render = ->(params) { component.new(params) } if component
      @render = render               if render
      @render = block                if block

      location = attributes.delete(:location) || $$.window.location.pathname
      @attributes = attributes
      # @attributes[:key] ||= location

      @@locations = [ location ]
      @@matched   = [false]
    end

    def render
      div(@attributes, [@render.call])
    end

    def self.locations
      return @@locations
    end

    def self.matched
      return @@matched
    end

  end
end
