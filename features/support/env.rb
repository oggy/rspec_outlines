require 'fileutils'
require 'rspec/expectations'
require 'ruby-debug'

ROOT = File.dirname(File.dirname(File.dirname(__FILE__)))
TMP = "#{ROOT}/features/tmp"

Debugger.start

Before do
  FileUtils.mkdir_p(TMP)
end

After do
  FileUtils.rm_rf(TMP)
end
