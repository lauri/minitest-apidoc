require 'minitest/apidoc/reporter'

module Minitest
  def self.plugin_apidoc_init(options)
    self.reporter << Apidoc::Reporter.new
  end
end