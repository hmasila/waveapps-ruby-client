# Waveapps

The Waveapps Ruby library provides convenient access to the Waveapps GraphQL API from applications written in the Ruby language. It includes a pre-defined set of classes for API resources that initialize themselves dynamically from API responses.

The library provides easy configuration path for fast setup and use. It also has helpers for pagination when listing resources. The `page` and `page_size` attributes will handle pagination in all resources.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'waveapps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install waveapps

## Usage

The library needs to be configured with your account's access token which is available in your Waveapps Account. Set Waveapps.access_token to its value:

```ruby
require "waveapps"
Waveapps.access_token = "sjblah_..."
```
See [examples](/examples) for specific methods

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hmasila/waveapps-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Waveapps project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hmasila/waveapps-ruby-client/blob/master/CODE_OF_CONDUCT.md).
