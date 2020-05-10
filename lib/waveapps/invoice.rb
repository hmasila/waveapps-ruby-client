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
      response = Waveapps::Api::Client.query(
        ListInvoicesQuery, variables: {
          businessId: business_id, page: page, pageSize: page_size
        })

      if response.data && response.data.business
        return response.data.business.invoices.edges.map(&:node)
      end
      Waveapps::Api.handle_errors(response, :business)
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

      response = Waveapps::Api::Client.query(
        CreateInvoiceQuery, variables: {
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

      if response.data && response.data.invoice_create
        return response.data.invoice_create
      end
      Waveapps::Api.handle_errors(response, :invoice_create)
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

    def self.delete_invoice(invoice_id:)
      response = Waveapps::Api::Client.query(DeleteInvoiceQuery, variables:
        { input: { invoiceId: invoice_id }
      })

      if response.data && response.data.invoice_delete
        return response.data.invoice_delete
      end
      Waveapps::Api.handle_errors(response, :invoice_delete)
    end

    SendInvoiceQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
      mutation ($input: InvoiceSendInput!) {
        invoiceSend(input: $input) {
          didSucceed
          inputErrors {
            message
            code
            path
          }
        }
      }
    GRAPHQL

    def self.send_invoice(subject: "", message: "", attach_pdf: false, invoice_id:, to: )
      response = Waveapps::Api::Client.query(
        SendInvoiceQuery, variables: {
          input: {
            invoiceId: invoice_id,
            to: to,
            attachPDF: attach_pdf,
            subject: subject,
            message: message
          }
        })

      if response.data && response.data.invoice_send
        return response.data.invoice_send
      end
      Waveapps::Api.handle_errors(response, :invoice_send)
    end

    ApproveInvoiceQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
      mutation ($input: InvoiceApproveInput!) {
        invoiceApprove(input: $input) {
          didSucceed
          inputErrors {
            message
            code
            path
          }
        }
      }
    GRAPHQL

    def self.approve_invoice(invoice_id: )
      response = Waveapps::Api::Client.query(ApproveInvoiceQuery, variables: {
        input: { invoiceId: invoice_id }
      })

      if response.data && response.data.invoice_approve
        return response.data.invoice_approve
      end
      Waveapps::Api.handle_errors(response, :invoice_approve)
    end

    MarkSentInvoiceQuery = Waveapps::Api::Client.parse <<-'GRAPHQL'
      mutation ($input: InvoiceMarkSentInput!) {
        invoiceMarkSent(input: $input) {
          didSucceed
          inputErrors {
            message
            code
            path
          }
        }
      }
    GRAPHQL

    def self.mark_as_sent(sent_at: nil, send_method: , invoice_id: )
      response = Waveapps::Api::Client.query(
        MarkSentInvoiceQuery, variables: {
          input: {
            invoiceId: invoice_id,
            sentAt: sent_at,
            sendMethod: send_method
          }
        })

      if response.data && response.data.invoice_mark_sent
        return response.data.invoice_mark_sent
      end
      Waveapps::Api.handle_errors(response, :invoice_mark_sent)
    end
  end
end
