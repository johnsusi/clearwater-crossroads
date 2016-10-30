module Crossroads

  class Match

    include Clearwater::Component

    def initialize(attributes = {}, pattern:, component: nil, render: nil, &block)
      @names = []
      if pattern.kind_of?(Regexp)
        @pattern = pattern
      else
        @pattern = Regexp.new( pattern.split('/').map { |part|
          md = /:([a-z]+)/.match(part)
          if md.nil?
            Regexp.escape(part)
          else
            @names << part[1..-1]
            '([^\/.+])'
          end
        }.join('\/') )
      end

      @attributes = attributes
      # @attributes[:key] ||= pattern

      @render = ->(params) { component.new(params) } if component
      @render = render               if render
      @render = block                if block
    end

    def render
      return nil if Router.matched.last == true
      location = Router.locations.last
      md = @pattern.match(location)
      return nil if md.nil?
      params = {}
      @names.each_with_index { |name, i| params[name] = md[i+1] }
      Router.locations.push(location[md.offset(0)[1]..-1])
      Router.matched.push(false)

      result = div(@attributes, [@render.call(params)])

      Router.matched.pop()
      Router.locations.pop()
      Router.matched.pop()
      Router.matched.push(true)

      return result
    end
  end
end
