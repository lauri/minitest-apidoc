module Minitest
  module Apidoc
    class Group
      attr_accessor :name, :endpoints

      def initialize(name, endpoints)
        @name = name || ""
        @endpoints = endpoints
      end

      # Takes a hash containing endpoint names as keys and endpoint objects as
      # values
      #
      # {"Widgets::Index" => #<Minitest::Apidoc::Endpoint>}, ...)
      #
      # and turns it into an array containing group objects so that the
      # endpoints whose group attribute is the same are put in the same group.
      #
      # [#<Minitest::Apidoc::Group>, ...]
      #
      # Sorts groups by name and endpoints within each group as specified by
      # Endpoint#sort_index. The template works with this array to display the
      # documentation.
      def self.from(endpoint_hash)
        endpoint_hash
          .values
          .sort_by(&:sort_index)
          .group_by { |endpoint| endpoint.group }
          .map { |name, endpoints| Group.new(name, endpoints) }
          .sort_by(&:name)
      end
    end
  end
end