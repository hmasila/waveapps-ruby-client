# Invoice

## Create invoice

```ruby
Waveapps::Invoice.create_invoice(business_id: <BUSINESS_ID>, customer_id: <CUSTOMER_ID>, items: [{product_id: <PRODUCT_ID>}])
```
Optional arguments

`status`, `currency`, `title`, `invoice_number`,
`po_number`, `invoice_date`, `exchange_rate`, `due_date`,
`memo`, `footer`, `disable_amex_payments`, `disable_credit_card_payments`,
`disable_bank_payments`, `item_title`, `unit_title`, `price_title`, `amount_title`, `hide_name`, `hide_description`, `hide_unit`, `hide_price`, `hide_amount`

## List invoices
```ruby
Waveapps::Invoice.list_invoices(business_id: <BUSINESS_ID>)
```

## Send invoice

Provide email of recipients in the `to` argument. If you have more than one recipient, pass it as an array.

```ruby
Waveapps::Invoice.send_invoice(invoice_id: <INVOICE_ID>, to: [<EMAIL>])
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

Provide one of the following for `send_method`
`EXPORT_PDF`, `GMAIL`, `MARKED_SENT`, `NOT_SENT`, `OUTLOOK`, `SHARED_LINK`, `SKIPPED`, `WAVE`, `YAHOO`

```ruby
Waveapps::Invoice.mark_as_sent(invoice_id: <INVOICE_ID>, send_method: <SEND_METHOD>)
```

Optional arguments

`sent_at`

If `sent_at` is not provided, Wave will use the current time
