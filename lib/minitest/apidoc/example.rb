module Minitest
  module Apidoc
    class Example
      attr_reader :name

      def initialize(test_class)
        @name = test_class.metadata[:example_name]
        @session = test_class.metadata[:session]
        @request = @session.last_request
        @response = @session.last_response
      end

      def request_method
        @request.request_method
      end

      def request_path
        @request.fullpath
      end

      def request_headers
        format_headers(@session.instance_variable_get(:@headers))
      end

      def request_body
        format_json(@request.body.read) unless @request.body.size.zero?
      end

      def response_status
        "#{@response.status} #{Rack::Utils::HTTP_STATUS_CODES[@response.status]}"
      end

      def response_headers
        format_headers(@response.headers)
      end

      def response_body
        format_json(@response.body)
      end

      private

      def format_json(string)
        JSON.pretty_generate(JSON.load(string))
      rescue JSON::ParserError, JSON::GeneratorError
        string
      end

      def format_headers(hash)
        hash.to_a.map { |name, value| "#{name}: #{value} "}.join($/)
      end
    end
  end
end