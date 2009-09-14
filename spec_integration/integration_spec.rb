require 'spec_helper'
require 'rbconfig'

SPEC_FILE_DIRECTORY = "#{ROOT}/spec_integration/spec_files"

describe "RSpec Outlines" do
  def spec
    suffix = Config::CONFIG['ruby_install_name'].sub(/\Aruby/, '')
    basename = "spec#{suffix}"
    ENV['PATH'].split(/:/).each do |dirname|
      path = File.join(dirname, basename)
      return path if File.file?(path) && File.executable?(path)
    end
  end

  def run_spec_file(path)
    original_rubylib = ENV['RUBYLIB']
    ENV['RUBYLIB'] = "#{ROOT}/lib"
    begin
      output = `#{spec} "#{path}" 2>&1`
      output[/.*/]
    ensure
      ENV['RUBYLIB'] = original_rubylib
    end
  end

  Dir["#{SPEC_FILE_DIRECTORY}/*.rb"].each do |path|
    name = File.basename(path).sub(/_spec\.rb\z/, '').gsub(/_/, ' ')
    expected = File.read(path).match(/\A# expect: (.*)/)[1]
    it(name){run_spec_file(path).should == expected}
  end
end
