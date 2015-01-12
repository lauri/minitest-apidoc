require 'minitest' # Requires apidoc_plugin.rb automatically

require 'minitest/minitest_ext'
require 'minitest/apidoc/methods'
require 'minitest/apidoc/group'
require 'minitest/apidoc/endpoint'
require 'minitest/apidoc/template'

module Minitest
  module Apidoc
    def self.enable_plugin!
      Apidoc::Reporter.enable_plugin = true
    end
  end
end