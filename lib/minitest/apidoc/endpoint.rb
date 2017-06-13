module Minitest
  module Apidoc
    class Endpoint
      attr_accessor :metadata, :params, :examples

      def initialize(test_class)
        @params = test_class.params
        @metadata = test_class.metadata
        @examples = []
      end

      # If request method is specified explicitly in the metadata by the user,
      # prefer that. If not, grab the request method that was actually used by
      # rack-test (stored in the example).
      def request_method
        @metadata[:request_method] || @examples[0].request_method
      end

      # Ditto
      def request_path
        @metadata[:request_path] || @examples[0].request_path.split("?")[0]
      end

      def html_anchor
        "#{request_method}-#{request_path}"
      end

      def html_class
        request_method.downcase
      end

      # Used in the Mustache template to determine if the params block should
      # be rendered.
      def params?
        !params.empty?
      end

      # Sort order for endpoints: first sort by request method (HEAD, GET, ...)
      # and then by length of request path (shortest first).
      def sort_index
        1000 * Methods::VERBS.index(request_method.downcase) + request_path.length
      end

      def method_missing(name, *args, &block)
        @metadata[name]
      end

      def respond_to_missing?(name, *)
        @metadata.include?(name) || super
      end
    end
  end
end
