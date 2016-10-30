require 'clearwater'
require 'clearwater-crossroads'

module Crossroads

  dsl = class DSL
    include Clearwater::Component
  end.new

  RSpec.describe Miss do

    it "should match the Miss route if no Matches are valid" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          Match.new(pattern: '/hello/not-world') { 'not hello world' },
          Match.new(pattern: '/hello/also-not-world') { 'also not hello world' },
          Miss.new { 'hello world' }
        ])
      end.to_s

      expect(html).to eq('<div><div><div>hello world</div></div></div>')

    end

    it "should not matter what order Miss and Match are in" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          Miss.new { 'hello world' },
          Match.new(pattern: '/hello/not-world') { 'not hello world' },
          Match.new(pattern: '/hello/also-not-world') { 'also not hello world' }
        ])
      end.to_s

      expect(html).to eq('<div><div><div>hello world</div></div></div>')

    end


  end
end