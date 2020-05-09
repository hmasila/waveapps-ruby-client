# frozen_string_literal: true

module Waveapps
  class << self
    attr_accessor :access_token
  end
  class Api
    API_URL = 'https://gql.waveapps.com/graphql/public'
    HTTP = GraphQL::Client::HTTP.new(API_URL) do
      def headers(_context)
        # Optionally set any HTTP headers
        {
          'Authorization' => "Bearer #{Waveapps.access_token}"
        }
      end
    end

    # Fetch latest schema on init, this will make a network request
    Schema = GraphQL::Client.load_schema(HTTP)

    # However, it's smart to dump this to a JSON file and load from disk
    #
    # Run it from a script or rake task
    # rake schema:dump
    #
    # Schema = GraphQL::Client.load_schema("./tmp/schema.json")

    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
  end
end
