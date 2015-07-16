module Library
  # module Identifier
  module Identifier
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:prepend, Initializer)
      base.send(:class_variable_set, :@@group_identifier, 0)
    end

    # Module for class method
    module ClassMethods
      def group_identifier
        self.class_variable_get(:@@group_identifier)
      end

      def inc_identifier_or_init
        self.class_variable_set(:@@group_identifier, self.class_variable_get(:@@group_identifier) + 1)
      end
    end

    # Module for initialization
    module Initializer
      def initialize(*args)
        super(*args)
        @identifier = self.class.inc_identifier_or_init
      end
    end

    def identifier
      @identifier
    end

    def identifier_comparsion(first_item, second_item)
      first_item.class == second_item.class &&
        first_item.identifier == second_item.identifier
    end

    def eql?(other)
      identifier_comparsion(self, other)
    end

    def ==(other)
      identifier_comparsion(self, other)
    end
  end
end
