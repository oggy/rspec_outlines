module RSpecOutlines
  module ExampleMethods
    def method_missing(name, *args)
      if is_outline_field_name?(name) && args.empty?
        lookup_outline_field_name(name)
      else
        super
      end
    end

    def is_outline_field_name?(name)
      @_proxy.outline_values && @_proxy.outline_values.key?(name)
    end

    def lookup_outline_field_name(name)
      @_proxy.outline_values[name]
    end
  end
end
