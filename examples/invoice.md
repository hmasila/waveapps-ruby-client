# Invoice

## Create invoice

```ruby
Waveapps::Invoice.create_invoice(
  business_id: <BUSINESS_ID>,
  customer_id: <CUSTOMER_ID>,
  items: [
    {
      product_id: <PRODUCT_ID>
    }
  ]
)
```

### Optional arguments

`status`, `currency`, `title`, `invoice_number`,
`po_number`, `invoice_date`, `exchange_rate`, `due_date`,
`memo`, `footer`, `disable_amex_payments`, `disable_credit_card_payments`,
`disable_bank_payments`, `item_title`, `unit_title`, `price_title`, `amount_title`, `hide_name`, `hide_description`, `hide_unit`, `hide_price`, `hide_amount`

The `items` argument takes a mandatory `product_id` value and `taxes`, `quantity`, `description`,
`unit_price`. The `description` and `unit_price` will override the values in the product.

The `taxes` object inside `items` takes a mandatory `sales_tax_id` and an optional `amount`.

The default `status` on creation is `DRAFT`. You can override this to `SAVED` when calling this method

### Example with taxes

```ruby
Waveapps::Invoice.create_invoice(
  business_id: <BUSINESS_ID>,
  customer_id: <CUSTOMER_ID>,
  items: [
    {
      product_id: <PRODUCT_ID>,
      taxes: [
        {
          amount: 89.7,
          sales_tax_id: <SALES_TAX_ID>
        }
      ]
    }
  ]
)
```

### Example with product override

```ruby
Waveapps::Invoice.create_invoice(
  business_id: <BUSINESS_ID>,
  customer_id: <CUSTOMER_ID>,
  items: [
    {
      product_id: <PRODUCT_ID>,
      description: "5 Watt C7 light bulb",
      unit_price: "2.7",
      quantity: 5
    }
  ]
)
```


## List invoices
```ruby
Waveapps::Invoice.list_invoices(business_id: <BUSINESS_ID>)
```

### Optional arguments

`sort`, `status`, `currency`, `customer_id`, `source_id`, `invoice_date_start`,
`invoice_date_end`, `modified_at_after`, `modified_at_before`

The default `page_size` is 10 and `page` is 1

Check the allowed `sort` arguments [here](https://developer.waveapps.com/hc/en-us/articles/360019968212#invoicesort). By default, the results are sorted by `[CREATED_AT_DESC]`.


## Send invoice

Provide email of recipients in the `to` argument. If you have more than one recipient, pass it as an array.

```ruby
Waveapps::Invoice.send_invoice(invoice_id: <INVOICE_ID>, to: [<EMAIL>, <EMAIL>])
```

Optional arguments

`subject`, `message`, `attach_pdf`

The default value of `attach_pdf` is `false`


## Approve invoice

```ruby
Waveapps::Invoice.approve_invoice(invoice_id: <INVOICE_ID>)
```

## Delete invoice

```ruby
Waveapps::Invoice.delete_invoice(invoice_id: <INVOICE_ID>)
```

## Mark invoice as sent

Provide a `send_method` from one of the allowed methods [here](https://developer.waveapps.com/hc/en-us/articles/360019968212#invoicesendmethod)

```ruby
Waveapps::Invoice.mark_as_sent(invoice_id: <INVOICE_ID>, send_method: <SEND_METHOD>)
```

Optional arguments

`sent_at`

If `sent_at` is not provided, Wave will use the current time
