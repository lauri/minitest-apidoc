require 'mustache'

module MiniTest
  module Apidoc
    class Template < Mustache
      class << self
        attr_accessor :template_file, :output_file, :blurb
      end

      attr_reader :groups

      self.template_file = File.expand_path("../../template.mustache", File.dirname(__FILE__))
      self.output_file = "apidoc.html"

      def initialize(groups)
        @groups = groups
      end

      def blurb
        self.class.blurb
      end

      def write
        File.open(self.class.output_file, "w") do |file|
          file.write(render)
        end
      end
    end
  end
end