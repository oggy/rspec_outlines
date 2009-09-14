module RSpecOutlines
end

require 'rspec_outlines/error'
require 'rspec_outlines/example_group'
require 'rspec_outlines/example_methods'
require 'rspec_outlines/example_proxy'
require 'rspec_outlines/outline'

Spec::Example::ExampleGroup.send :extend, RSpecOutlines::ExampleGroup
Spec::Example::ExampleGroup.send :include, RSpecOutlines::ExampleMethods
Spec::Example::ExampleProxy.send :include, RSpecOutlines::ExampleProxy
