class String
  class SafeBuffer < String
    UNSAFE_STRING_METHODS = ["capitalize", "chomp", "chop", "delete", "downcase", "gsub", "lstrip", "next", "reverse", "rstrip", "slice", "squeeze", "strip", "sub", "succ", "swapcase", "tr", "tr_s", "upcase", "prepend"].freeze

    alias_method :original_concat, :concat
    private :original_concat

    class SafeConcatError < StandardError
      def initialize
        super "Could not concatenate to the buffer because it is not html safe."
      end
    end

    def[](*args)
      new_safe_buffer = super
      new_safe_buffer.instance_eval { @dirty = false }
      new_safe_buffer
    end

    def safe_concat(value)
      raise SafeConcatError if dirty?
      original_concat(value)
    end

    def initialize(*)
      @dirty = false
      super
    end

    def initialize_copy(other)
      super
      @dirty = other.dirty?
    end

    def concat(value)
      if dirty? || value.html_safe?
        super(value)
      else
        super(ERB::Util.h(value))
      end
    end
    alias << concat

    def +(other)
      dup.concat(other)
    end

    def html_safe?
      !dirty?
    end

    def to_s
      self
    end

    def to_param
      to_str
    end

    def encode_with(coder)
      coder.represent_scalar nil, to_str
    end

    def to_yaml(*args)
      return super() if defined?(YAML::ENGINE) && !YAML::ENGINE.syck?
      to_str.to_yaml(*args)
    end

    UNSAFE_STRING_METHODS.each do |unsafe_method|
      if 'String'.respond_to?(unsafe_method)
        class_eval <<-EOT, __FILE__, __LINE__ + 1
          def #{unsafe_method}(*args, &block)       # def capitalize(*args, &block)
            to_str.#{unsafe_method}(*args, &block)  #   to_str.capitalize(*args, &block)
          end                                       # end

          def #{unsafe_method}!(*args)              # def capitalize!(*args)
            @dirty = true                           #   @dirty = true
            super                                   #   super
          end                                       # end
        EOT
      end
    end

    protected

    def dirty?
      @dirty
    end
  end

  def html_safe
    SafeBuffer.new self
  end
end
