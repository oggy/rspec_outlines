module RSpecOutlines
  Error = Class.new(RuntimeError)

  module ExampleGroup
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def outline(name=nil, &definition)
        if name
          outline_body = lambda { |x| it(name, &definition) }
        else
          outline_body = definition
        end
        @current_outline = Outline.new(self, &outline_body)
      end

      def current_outline
        @current_outline ||= nil
      end

      def fields(*names)
        current_outline or
          raise Error, "no outline defined"
        current_outline.fields = names
      end

      def values(*args)
        current_outline.eval(*args)
      end

      def instance_eval_with_outline_binding(outline_binding, &block)
        original_outline_binding = @current_outline_binding
        @current_outline_binding = outline_binding
        begin
          instance_eval(&block)
        ensure
          @current_outline_binding = original_outline_binding
        end
      end

      attr_reader :current_outline_binding
    end

    def method_missing(name, *args)
      outline_binding = example.outline_binding
      if outline_binding && outline_binding.defined?(name)
        args.empty? or
          raise ArgumentError, "wrong number of arguments (#{args.size} for 0)"
        outline_binding[name]
      else
        super
      end
    end
  end

  module Example
    def self.included(base)
      base.class_eval do
        alias initialize_without_rspec_outlines initialize
        alias initialize initialize_with_rspec_outlines
      end
    end

    def initialize_with_rspec_outlines(*args, &block)
      initialize_without_rspec_outlines(*args, &block)
      @outline_binding = @example_group_class.current_outline_binding
    end

    attr_reader :outline_binding
  end

  class Outline
    def initialize(example_group, &definition)
      @example_group = example_group
      @definition = definition
      @fields = nil
    end

    attr_reader :example_group, :fields, :definition

    def fields=(fields)
      @fields = fields.map { |v| v.to_sym }
    end

    def eval(*values)
      fields or
        raise Error, "no fields defined"
      outline_binding = OutlineBinding.new(fields, values)
      example_group.instance_eval_with_outline_binding(outline_binding, &definition)
    end
  end

  class OutlineBinding
    def initialize(names=[], values=[])
      @fields = {}
      merge!(names, values)
    end

    def merge(names, values)
      names.length == values.length or
        raise ArgumentError, "wrong number of values (#{fields.length} fields, #{values.length} values given)"
      dup.merge!(names, values)
    end

    def defined?(name)
      @fields.key?(name)
    end

    def [](name)
      @fields[name]
    end

    private

    def merge!(names, values)
      names.zip(values) do |name, value|
        @fields[name] = value
      end
    end

    attr_reader :fields
  end
end

RSpec::Core::ExampleGroup.send :include, RSpecOutlines::ExampleGroup
RSpec::Core::Example.send :include, RSpecOutlines::Example
