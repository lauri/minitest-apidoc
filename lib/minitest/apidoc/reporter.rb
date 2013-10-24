module Minitest
  module Apidoc
    class Reporter < Minitest::Reporter

      def initialize
        @endpoints = {}
        @tests = []
      end

      def record(test)
        if @tests.last.class != test.class
          @endpoints[test.class] = Endpoint.new
          @endpoints[test.class].metadata = test.class.metadata
          @endpoints[test.class].params = test.class.params
        end

        if test.passed?
          @endpoints[test.class].examples << {
            :title    => test.class.metadata[:example_name],
            :request  => test.class.metadata[:request],
            :response => test.class.metadata[:response]
          }
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