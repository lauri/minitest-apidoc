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
        @tests = []
      end

      def record(test)
        if @tests.last.class != test.class
          @endpoints[test.class] = Endpoint.new(test.class)
        end

        if test.passed?
          @endpoints[test.class].examples << Example.new(test.class)
        end

        @tests << test
      end

      def passed?
        groups = Group.from(@endpoints)
        Template.new(groups).write
      end
    end
  end
end