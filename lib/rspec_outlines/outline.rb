module RSpecOutlines
  class Outline
    def initialize(example_group, name, &definition)
      @example_group = example_group
      @name = name
      @definition = definition
      @fields = nil
      @number_of_examples = 0
    end

    attr_reader :name
    attr_accessor :fields

    def instantiate(*values)
      fields or
        raise Error, "no fields defined"
      fields.length == values.length or
        raise ArgumentError, "wrong number of values (#{fields.length} fields, #{values.length} values)"
      example = @example_group.example("#{name} - #{@number_of_examples += 1}", &@definition)
      example.outline_values = Hash[*fields.zip(values).flatten]
    end
  end
end
