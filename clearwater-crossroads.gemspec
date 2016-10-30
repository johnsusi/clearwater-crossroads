%w(lib shared).each do |dir|
  path = File.expand_path(File.join("..", dir), __FILE__)
  $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
end

require 'crossroads/version'

Gem::Specification.new do |s|
  s.name        = 'clearwater-crossroads'
  s.version     = Crossroads::VERSION
  s.date        = '2016-10-29'
  s.summary     = "A declarative router for Clearwater"
  s.description = s.summary
  s.authors     = ["John Susi"]
  s.email       = 'john@susi.se'
  s.files       = [
    "lib/clearwater-crossroads.rb",
    "lib/crossroads/link.rb",
    "lib/crossroads/match.rb",
    "lib/crossroads/miss.rb",
    "lib/crossroads/redirect.rb",
    "lib/crossroads/router.rb",
    "lib/crossroads/version.rb"
  ]
  s.require_paths = ['lib']
  s.homepage    = 'http://rubygems.org/gems/clearwater-crossroads'
  s.license     = 'MIT'
  s.add_runtime_dependency 'clearwater', '> 0.9', '< 2'
end