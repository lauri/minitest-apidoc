require 'minitest/reporters'

module Minitest
  module Apidoc
    class Reporter
      include MiniTest::Reporter

      def initialize
        @endpoints = {}
      end

      def before_suite(suite)
        @endpoints[suite.name] = Endpoint.new
        @endpoints[suite.name].metadata = suite.metadata
        @endpoints[suite.name].params = suite.params
      end

      def pass(suite, test, test_runner)
        @endpoints[suite.name].examples << {
          :title    => suite.metadata[:example_name],
          :request  => suite.metadata[:request],
          :response => suite.metadata[:response]
        }
      end

      def after_suites(suite, type)
        # TODO: find out where these empty endpoints come from
        @endpoints.reject! { |name, endpoint| endpoint.metadata.empty? }
        groups = Group.from(@endpoints)
        Template.new(groups).write
      end
    end
  end
end