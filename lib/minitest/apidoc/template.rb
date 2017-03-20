require "mustache"

module Minitest
  module Apidoc
    class Template < Mustache
      class << self
        attr_accessor :template_file, :output_file, :blurb
      end

      attr_reader :groups

      self.template_file = File.expand_path("../../../template.mustache", __FILE__)
      self.output_file = "apidoc.html"

      def initialize(groups)
        @groups = groups
      end

      def blurb
        self.class.blurb
      end

      def write
        File.write(self.class.output_file, render)
      end
    end
  end
end