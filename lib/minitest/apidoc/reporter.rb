require "minitest/apidoc/group"
require "minitest/apidoc/example"
require "minitest/apidoc/endpoint"
require "minitest/apidoc/template"

module Minitest
  module Apidoc
    class Reporter < Minitest::Reporter
      class << self
        attr_accessor :enable_plugin
      end

      def initialize
        super
        @endpoints = {}
      end

      def record(result)
        @endpoints[result.test_class] ||= Endpoint.new(result.test_class)

        if result.passed?
          @endpoints[result.test_class].examples << Example.new(result.test_class)
        end
      end

      def passed?
        groups = Group.from(@endpoints)
        Template.new(groups).write
      end
    end
  end
end
