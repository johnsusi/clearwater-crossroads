require_relative 'crossroads/router.rb'
require_relative 'crossroads/match.rb'
require_relative 'crossroads/miss.rb'
require_relative 'crossroads/link.rb'
require_relative 'crossroads/redirect.rb'

unless RUBY_ENGINE == 'opal'
  begin
    require 'opal'
    Opal.append_path File.expand_path('..', __FILE__).untaint
  rescue LoadError
  end
end