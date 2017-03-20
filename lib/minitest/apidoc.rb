require "json"
require "minitest" # Requires apidoc_plugin.rb automatically
require "minitest/minitest_ext"
require "minitest/apidoc/version"
require "minitest/apidoc/methods"
require "minitest/apidoc/reporter"

module Minitest
  module Apidoc
    def self.enable_plugin!
      Reporter.enable_plugin = true
    end
  end
end