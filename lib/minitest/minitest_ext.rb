module Minitest
  class Test < Runnable
    class << self
      def metadata
        @metadata ||= {}
      end

      def params
        @params ||= []
      end

      def example(desc=nil, &block)
        it desc do
          self.class.metadata[:example_name] = desc
          self.instance_eval(&block)
        end
      end

      def meta(key, value)
        metadata[key] = value
      end

      def param(name, description, options={})
        params << {name: name, description: description}.merge(options)
      end
    end
  end
end

module Kernel
  # `document` is an alias for `describe` but it also declares the tests
  # order-dependent. This is because we would like to have the documentation
  # always in the same order.
  def document(desc, additional_desc=nil, &block)
    describe desc, additional_desc do
      i_suck_and_my_tests_are_order_dependent!
      self.instance_eval(&block)
    end
  end
end
