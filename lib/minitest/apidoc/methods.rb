module MiniTest
  module Apidoc
    module Methods
      include Rack::Test::Methods

      VERBS = %w[get head post put patch delete options]

      def _request(verb, uri, params={}, env={}, &block)
        send("rack_test_#{verb}", uri, params, env)

        self.class.metadata[:request] = "#{verb.upcase} #{last_request.fullpath}"
        self.class.metadata[:request] << $/ + last_request.body.read if last_request.body

        begin
          response_data = JSON.load(last_response.body)
          formatted_response = JSON.pretty_generate(response_data)
        rescue JSON::ParserError
          response_data = last_response.body
          formatted_response = last_response.body
        end

        self.class.metadata[:response] = formatted_response
        block.call(response_data)
      end

      VERBS.each do |verb|
        alias_method "rack_test_#{verb}", verb
        define_method(verb) do |uri, params={}, env={}, &block|
          _request(verb, uri, params, env, &block)
        end
      end
    end
  end
end