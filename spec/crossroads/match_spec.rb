require 'clearwater'
require 'clearwater-crossroads'

module Crossroads

  dsl = class DSL
    include Clearwater::Component
  end.new

  RSpec.describe Match do

    it "should match a route that are a direct descendants of Router" do

      html = Router.new(location: '/hello/world') do
        Match.new(pattern: '/hello/world') { 'hello world' }
      end.to_s

      expect(html).to eq('<div><div>hello world</div></div>')

    end

    it "should match a route that are a deep descendant of Router" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          dsl.div([
            Match.new(pattern: '/hello/world') { 'hello world' }
          ])
        ])
      end.to_s

      expect(html).to eq('<div><div><div><div>hello world</div></div></div></div>')

    end

    it "should match the first route that is valid" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          Match.new(pattern: '/hello/not-world') { 'not hello world' },
          Match.new(pattern: '/hello/also-not-world') { 'also not hello world' },
          Match.new(pattern: '/hello/world') { 'hello world' },
          Match.new(pattern: '/hello/world') { 'the wrong hello world' },
          Match.new(pattern: '/hello/world') { 'another wrong hello world' },
          Match.new(pattern: '/hello/world') { 'this is also not the correct hello world' },
        ])
      end.to_s

      expect(html).to eq('<div><div><div>hello world</div></div></div>')

    end

    it "should match with params" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          Match.new(pattern: '/hello/:name') { |params| "hello #{params['name']}" }
        ])
      end.to_s

      expect(html).to eq('<div><div><div>hello world</div></div></div>')

    end

    it "should match recursivly" do

      html = Router.new(location: '/hello/world') do
        dsl.div([
          Match.new(pattern: '/hello') {
            Match.new(pattern: '/:name') { |params| "hello #{params['name']}" }
          }
        ])
      end.to_s

      expect(html).to eq('<div><div><div><div>hello world<div></div></div></div>')

    end

    it "should match using short form" do

      html = Router.new(location: '/hello/world') do
        Crossroads::match('/hello') { 'hello world' }
      end.to_s

      expect(html).to eq('<div><div>hello world</div></div>')

    end


  end
end