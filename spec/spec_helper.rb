ROOT = File.dirname(File.dirname(__FILE__))

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec_outlines'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

# So we don't have to qualify all our classes.
include RSpecOutlines
