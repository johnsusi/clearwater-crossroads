require 'opal'
require 'clearwater'
require 'ostruct'
require 'clearwater-crossroads'

class Layout
  include Clearwater::Component
  include Crossroads

  def render
    router do
      div({ id: 'app' }, [
        header({ class_name: 'main-header' }, [
          h1('Hello, world!'),
        ]),
        match('/articles') { Articles.new },
        miss { link('/articles') { 'List articles' } }
      ])
    end
  end
end

class Articles
  include Clearwater::Component
  include Crossroads

  def render
    div({ id: 'articles-container '}, [
      input({ class_name: 'search-articles', onkeyup: method(:search) }),
      ul({ id: 'articles-index' }, articles.map { |article|
        ArticlesListItem.new(article)
      }),
      Match.new(pattern: '/:article_id', component: Article)
    ])
  end

  def articles
    @articles ||= MyStore.fetch_articles

    if @query
      @articles.select { |article| article.match?(@query) }
    else
      @articles
    end
  end

  def search(event)
    @query = event.target.value
    call # Rerender the app
  end
end

class ArticlesListItem
  include Clearwater::Component

  attr_reader :article

  def initialize(article)
    @article = article
  end

  def render
    # Note the "key" key in this hash. This is a hint to the virtual DOM that
    # if this node is moved around, it can still reuse the same element.
    li({ key: article.id, class_name: 'article' }, [
      # The Link component will rerender the app for the new URL on click
      Link.new({ href: "/articles/#{article.id}" }, article.title),
      time({ class_name: 'timestamp' }, article.timestamp.strftime('%m/%d/%Y')),
    ])
  end
end

class Article
  include Clearwater::Component

  def initialize(article_id:)
    @article_id = article_id
  end

  def render
    # In addition to using HTML5 tag names as methods, you can use the `tag`
    # method with a query selector to generate a tag with those attributes.
    tag('article.selected-article', nil, [
      h1({ class_name: 'article-title' }, article.title),
      time({ class_name: 'article-timestamp' }, article.timestamp.strftime('%m-%d-%Y')),
      section({ class_name: 'article-body' }, article.body),
    ])
  end

  def article
    # params[:article_id] is the section of the URL that contains what would be
    # the `:article_id` parameter in the router below.
    MyStore.article(@article_id)
  end

  def match? query
    query.split.all? { |token|
      title.include?(token) || body.include?(token)
    }
  end
end

module MyStore
  extend self
  DB = 5.times.map do |n|
    OpenStruct.new(id: n, timestamp: Time.new, title: "Random thoughts n.#{n}", body: 'Some deep stuff')
  end

  def fetch_articles
    DB
  end

  def article(id)
    id = id.to_i
    DB.find {|a| a.id == id}
  end
end

Clearwater::Application.new(
  component: Layout.new
).call


