# Waveapps Ruby Client

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/waveapps`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'waveapps-ruby-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install waveapps-ruby-client

## Usage

The library needs to be configured with your account's access token which is available in your Waveapps Account. Set Waveapps.access_token to its value:

```ruby
require "waveapps-ruby-client"
Waveapps.access_token = "sjblah_..."
```


### Create invoices
Replace `<BUSINESS_ID>`, `<CUSTOMER_ID>`, and `<PRODUCT_ID>` with real ids.

```ruby
Waveapps::Invoice.create_invoice(business_id: <BUSINESS_ID>, customer_id: <CUSTOMER_ID>, items: [{product_id: <PRODUCT_ID>}])
```
Optional arguments

`status`, `currency`, `title`, `invoice_number`,
`po_number`, `invoice_date`, `exchange_rate`, `due_date`,
`memo`, `footer`, `disable_amex_payments`, `disable_credit_card_payments`,
`disable_bank_payments`, `item_title`, `unit_title`, `price_title`, `amount_title`, `hide_name`, `hide_description`, `hide_unit`, `hide_price`, `hide_amount`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hmasila/waveapps-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Waveapps project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hmasila/waveapps-ruby-client/blob/master/CODE_OF_CONDUCT.md).
