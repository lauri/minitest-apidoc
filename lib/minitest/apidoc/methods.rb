require "rack/test"

module Minitest
  module Apidoc
    module Methods
      include Rack::Test::Methods

      VERBS = %w[head get post put patch delete options]

      # Takes over rack-test's `get`, `post`, etc. methods (first aliasing the
      # originals so that they can still be used). This way we can call the
      # methods normally in our tests but they perform all the documentation
      # goodness.
      VERBS.each do |verb|
        alias_method "rack_test_#{verb}", verb
        define_method(verb) do |uri, params={}, env={}, &block|
          _request(verb, uri, params, env, &block)
        end
      end

      # Performs a rack-test request while also saving the metadata necessary
      # for documentation. Detects if the response is JSON (naively by just
      # trying to parse it as JSON). If it is, formats the response nicely and
      # also yields the data as parsed JSON object instead of raw text.
      def _request(verb, uri, params={}, env={})
        send("rack_test_#{verb}", uri, params, env)
        self.class.metadata[:session] = current_session

        response_data = begin
          JSON.load(last_response.body)
        rescue JSON::ParserError
          last_response.body
        end

        yield response_data if block_given?
      end
    end
  end
end
