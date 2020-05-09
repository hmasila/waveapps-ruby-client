# frozen_string_literal: true

module Waveapps
  class Invoice
    ListInvoicesQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
  		query($businessId: ID!, $page: Int!, $pageSize: Int!) {
			  business(id: $businessId) {
			    id
			    isClassicInvoicing
			    invoices(page: $page, pageSize: $pageSize) {
			      pageInfo {
			        currentPage
			        totalPages
			        totalCount
			      }
			      edges {
			        node {
			          id
			          createdAt
			          modifiedAt
			          pdfUrl
			          viewUrl
			          status
			          title
			          subhead
			          invoiceNumber
			          invoiceDate
			          poNumber
			          customer {
			            id
			            name
			            # Can add additional customer fields here
			          }
			          currency {
			            code
			          }
			          dueDate
			          amountDue {
			            value
			            currency {
			              symbol
			            }
			          }
			          amountPaid {
			            value
			            currency {
			              symbol
			            }
			          }
			          taxTotal {
			            value
			            currency {
			              symbol
			            }
			          }
			          total {
			            value
			            currency {
			              symbol
			            }
			          }
			          exchangeRate
			          footer
			          memo
			          disableCreditCardPayments
			          disableBankPayments
			          itemTitle
			          unitTitle
			          priceTitle
			          amountTitle
			          hideName
			          hideDescription
			          hideUnit
			          hidePrice
			          hideAmount
			          items {
			            product {
			              id
			              name
			              # Can add additional product fields here
			            }
			            description
			            quantity
			            price
			            subtotal {
			              value
			              currency {
			                symbol
			              }
			            }
			            total {
			              value
			              currency {
			                symbol
			              }
			            }
			            account {
			              id
			              name
			              subtype {
			                name
			                value
			              }
			              # Can add additional account fields here
			            }
			            taxes {
			              amount {
			                value
			              }
			              salesTax {
			                id
			                name
			                # Can add additional sales tax fields here
			              }
			            }
			          }
			          lastSentAt
			          lastSentVia
			          lastViewedAt
			        }
			      }
			    }
			  }
			}
    GRAPHQL

    def self.list_invoices(page: 1, page_size: 10, business_id:)
      result = Waveapps::Api::Client.query(ListInvoicesQuery, variables: {
                                             businessId: business_id, page: page, pageSize: page_size
                                           }).data
      return nil if result.business.nil?

      result.business.invoices.edges.map(&:node)
    end

    CreateInvoiceQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
  		mutation ($input: InvoiceCreateInput!) {
			  invoiceCreate(input: $input) {
			    didSucceed
			    inputErrors {
			      message
			      code
			      path
			    }
			    invoice {
			      id
			      createdAt
			      modifiedAt
			      pdfUrl
			      viewUrl
			      status
			      title
			      subhead
			      invoiceNumber
			      invoiceDate
			      poNumber
			      customer {
			        id
			        name
			        # Can add additional customer fields here
			      }
			      currency {
			        code
			      }
			      dueDate
			      amountDue {
			        value
			        currency {
			          symbol
			        }
			      }
			      amountPaid {
			        value
			        currency {
			          symbol
			        }
			      }
			      taxTotal {
			        value
			        currency {
			          symbol
			        }
			      }
			      total {
			        value
			        currency {
			          symbol
			        }
			      }
			      exchangeRate
			      footer
			      memo
			      disableCreditCardPayments
			      disableBankPayments
			      itemTitle
			      unitTitle
			      priceTitle
			      amountTitle
			      hideName
			      hideDescription
			      hideUnit
			      hidePrice
			      hideAmount
			      items {
			        product {
			          id
			          name
			          # Can add additional product fields here
			        }
			        description
			        quantity
			        price
			        subtotal {
			          value
			          currency {
			            symbol
			          }
			        }
			        total {
			          value
			          currency {
			            symbol
			          }
			        }
			        account {
			          id
			          name
			          subtype {
			            name
			            value
			          }
			          # Can add additional account fields here
			        }
			        taxes {
			          amount {
			            value
			          }
			          salesTax {
			            id
			            name
			            # Can add additional sales tax fields here
			          }
			        }
			      }
			      lastSentAt
			      lastSentVia
			      lastViewedAt
			    }
			  }
			}
    GRAPHQL

    def self.create_invoice(
      status: "DRAFT", currency: nil, title: nil, invoice_number: nil,
      po_number: nil, invoice_date: nil, exchange_rate: nil, due_date: nil,
      memo: nil, footer: nil, disable_amex_payments: nil, disable_credit_card_payments: nil,
      disable_bank_payments: nil, item_title: nil, unit_title: nil, price_title: nil,
      amount_title: nil, hide_name: nil, hide_description: nil, hide_unit: nil,
      hide_price: nil, hide_amount: nil, items:, business_id:, customer_id:
    )

      Waveapps::Api::Client.query(CreateInvoiceQuery, variables: {
                                    input: {
                                      businessId: business_id,
                                      customerId: customer_id,
                                      items: items.map do |pid|
                                               {
                                                 productId: pid[:product_id],
                                                 quantity: pid[:quantity],
                                                 description: pid[:description],
                                                 unitPrice: pid[:unit_price]
                                               }
                                             end,
                                      status: status,
                                      currency: currency,
                                      title: title,
                                      invoiceNumber: invoice_number,
                                      poNumber: po_number,
                                      invoiceDate: invoice_date,
                                      exchangeRate: exchange_rate,
                                      dueDate: due_date,
                                      memo: memo,
                                      footer: footer,
                                      disableAmexPayments: disable_amex_payments,
                                      disableCreditCardPayments: disable_credit_card_payments,
                                      disableBankPayments: disable_bank_payments,
                                      itemTitle: item_title,
                                      unitTitle: unit_title,
                                      priceTitle: price_title,
                                      amountTitle: amount_title,
                                      hideName: hide_name,
                                      hideDescription: hide_description,
                                      hideUnit: hide_unit,
                                      hidePrice: hide_price,
                                      hideAmount: hide_amount
                                    }
                                  })
    end

    DeleteInvoiceQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
  		mutation ($input: InvoiceDeleteInput!) {
  			invoiceDelete(input: $input) {
			    didSucceed
			    inputErrors {
			      code
			      message
			      path
			    }
			  }
  		}
    GRAPHQL

    def self.delete_invoice(id)
      result = Waveapps::Api::Client.query(DeleteInvoiceQuery, variables: { input: { id: id } })
      result.data
    end
  end
end
