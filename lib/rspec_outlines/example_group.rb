module RSpecOutlines
  module ExampleGroup
    def outline(name, &definition)
      @current_outline = Outline.new(self, name, &definition)
    end

    def current_outline
      @current_outline ||= nil
    end

    def fields(*names)
      need_outline
      current_outline.fields = names.map{|name| name.to_sym}
    end

    def values(*args)
      need_outline
      current_outline.instantiate(*args)
    end

    private  # -------------------------------------------------------

    def need_outline
       current_outline or
        raise Error, "no outline defined"
    end
  end
end
