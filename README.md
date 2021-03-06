Declarative router for [Clearwater]
--------------------------------------------------------------------------------

Being a long time sceptic about the need for a router in single page apps I was
recently tasked with something that could probably be done using a router.

Doing some background research I came across this video:

[![youtube link](http://img.youtube.com/vi/Vur2dAFZ4GE/0.jpg)](http://www.youtube.com/watch?v=Vur2dAFZ4GE "React Router v4")

The authors of react-router have come to the conclussion that designing
the router as some kind of special object was not the right approach. Instead
it can be implemented with components and in my opinion that reduces complexity
instead of adding to it.

Example:

```ruby

class App
  include Clearwater::Component
  include Crossroads

  def render
    router do
      div({id: 'app'}, [
        h1('Hello world'),
        ul([
          li([ link('/')         { 'Home'     } ]),
          li([ link('/about')    { 'About'    } ]),
          li([ link('/articles') { 'Articles' } ])
        ]),
        match('/about')    { About.new },
        match('/articles') { Articles.new},
        miss { div('Welcome') }
      ])
    end
  end
end

```

Now the routes are part of the rendering flow and can be reconfigured whenever
your model changes instead of being declared upfront.

I'm still not convinced you actually need a router but I'll put this online
for others to play with.

DISCLAIMER: This is still very early work. Do not depend on this gem in
            production.

[Clearwater]: https://github.com/clearwater-rb/clearwater

Try it out for yourself

```sh
git clone https://github.com/johnsusi/clearwater-crossroads crossroads
cd crossroads/demo
bundle install
bundle exec rackup
````

and point your browser to http://localhost:9292/


