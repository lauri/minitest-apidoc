module MiniTest
  module Apidoc
    class Group
      attr_accessor :name, :endpoints

      def initialize(name, endpoints)
        @name = name || ""
        @endpoints = endpoints
      end

      def self.from(endpoint_hash)
        grouped_endpoints = endpoint_hash.values.group_by { |endpoint| endpoint.group }
        grouped_endpoints.map { |group, endpoints| Group.new(group, endpoints) }
      end
    end
  end
end