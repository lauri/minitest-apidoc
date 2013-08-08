require 'minitest/spec'

module MiniTest
  class Unit
    class TestCase
      class << self
        def metadata
          @metadata ||= {}
        end

        def params
          @params ||= []
        end

        def example(desc, &block)
          it desc do
            self.class.metadata[:example_name] = desc
            self.instance_eval(&block)
          end
        end

        def meta(key, value)
          self.metadata[key] = value
        end

        def param(name, description, options={})
          self.params << {:name => name, :description => description}.merge(options)
        end
      end
    end
  end
end

module Kernel
  alias_method :document, :describe
end
