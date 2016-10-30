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
  s.description = "Render the router just like you would any other component. Use Matches and Miss for selecting the current path being visible."
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
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/crossroads/match_spec.rb"
  ]
  s.require_paths = ['lib']
  s.homepage    = 'https://github.com/johnsusi/clearwater-crossroads/'
  s.license     = 'MIT'
  s.add_runtime_dependency 'clearwater', '=1.0.0.rc4'
  s.add_development_dependency 'rspec', "~> 3.3"
end