require 'minitest/apidoc/reporter'

module Minitest
  def self.plugin_apidoc_init(options)
    self.reporter << Apidoc::Reporter.new if Apidoc::Reporter.enable_plugin
  end
end