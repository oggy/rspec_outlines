$:.unshift File.expand_path('lib', File.dirname(__FILE__))
require 'rspec_outlines/version'

Gem::Specification.new do |s|
  s.name = 'rspec_outlines'
  s.version = RSpecOutlines::VERSION
  s.author = 'George Ogata'
  s.email = 'george.ogata@gmail.com'
  s.date = Time.now.strftime('%Y-%m-%d')
  s.summary = "Cucumber scenario outlines for RSpec."
  s.homepage = 'http://github.com/oggy/rspec_outlines'

  s.files = Dir['lib/**/*.rb', 'CHANGELOG', 'LICENSE', 'Rakefile', 'README.markdown']
  s.test_files = Dir['features/**/*.rb']

  s.specification_version = 3
  s.add_dependency 'rspec', '~> 2.0'
  s.add_development_dependency 'ritual', '0.3.0'
  s.add_development_dependency 'cucumber'
  if RUBY_ENGINE == 'ruby'
    if RUBY_VERSION >= '1.9'
      s.add_development_dependency 'ruby-debug19'
    elsif
      s.add_development_dependency 'ruby-debug'
    end
  end
end
