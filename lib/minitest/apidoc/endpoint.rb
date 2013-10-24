module Minitest
  module Apidoc
    class Endpoint
      attr_accessor :metadata, :params, :examples

      def initialize
        @metadata = {}
        @examples = []
        @params   = []
      end

      def html_anchor
        "#{@metadata[:request_method]}-#{@metadata[:request_path]}"
      end

      def html_class
        @metadata[:request_method].downcase
      end

      def method_missing(name, *args, &block)
        @metadata[name]
      end

      def respond_to?(name)
        @metadata.include?(name) || super
      end
    end
  end
end