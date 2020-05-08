require "waveapps/ruby/version"
require "graphql/client"
require "graphql/client/http"
# require "waveapps/business"

module Waveapps
  class Error < StandardError; end
	API_URL = "https://gql.waveapps.com/graphql/public"
  WAVEAPPS_TOKEN = ENV.fetch('WAVEAPPS_TOKEN')

  HTTP = GraphQL::Client::HTTP.new(API_URL) do
    def headers(context)
      # Optionally set any HTTP headers
      {
      	"Authorization" => "Bearer #{WAVEAPPS_TOKEN}"
      }
    end
  end

  # Fetch latest schema on init, this will make a network request
  Schema = GraphQL::Client.load_schema(HTTP)

  # However, it's smart to dump this to a JSON file and load from disk
  #
  # Run it from a script or rake task
  #   GraphQL::Client.dump_schema(SWAPI::HTTP, "path/to/schema.json")
  #
  # Schema = GraphQL::Client.load_schema("path/to/schema.json")

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
