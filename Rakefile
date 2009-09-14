require 'rubygems'
require 'rake'

ROOT = File.dirname(__FILE__)

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec_outlines"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "george.ogata@gmail.com"
    gem.homepage = "http://github.com/oggy/rspec_outlines"
    gem.authors = ["George Ogata"]
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', "#{ROOT}/spec/spec.opts"]
end

Spec::Rake::SpecTask.new(:spec_integration) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec_integration/integration_spec.rb']
  spec.spec_opts = ['--options', "#{ROOT}/spec_integration/spec.opts"]
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rspec_outlines #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
