# frozen_string_literal: true

require 'graphql/client'
require 'graphql/client/http'

API_URL = 'https://gql.waveapps.com/graphql/public'
WAVEAPPS_TOKEN = ENV.fetch('WAVEAPPS_TOKEN')
HTTP = GraphQL::Client::HTTP.new(API_URL) do
  def headers(_context)
    # Optionally set any HTTP headers
    {
      'Authorization' => "Bearer #{WAVEAPPS_TOKEN}"
    }
  end
end
namespace :schema do
  desc "Dumps GraphQL Schema so that you don't have to make http requests every time"
  task :dump do
    GraphQL::Client.dump_schema(HTTP, './tmp/schema.json')
  end
end
