module Waveapps
  class Invoice
  	ListInvoicesQuery = Waveapps::Client.parse <<-'GRAPHQL'
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

		def self.list_invoices
  		result = Waveapps::Client.query(ListInvoicesQuery).data
  		return nil if result.nil?
  		result.business.invoices.edegs.map {|n| n.node}
  	end

  	CreateInvoiceQuery = Waveapps::Client.parse <<-'GRAPHQL'
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

    # {
		#   "input": {
		#     "businessId": "<BUSINESS_ID>",
		#     "customerId": "<CUSTOMER_ID>",
		#     "items": [
		#       {
		#         "productId": "<PRODUCT_ID>"
		#       }
		#     ]
		#   }
		# }
		
  	def self.create_invoice(items: , business_id: , customer_id: )
  		Waveapps::Client.query(CreateInvoiceQuery, variables: { 
  			input: {
  				businessId: business_id,
  				customerId: customer_id,
  				items: items.map { |pid| { productId: pid[:product_id] }}
  			}
  		})
  	end

  	DeleteInvoiceQuery = Waveapps::Client.parse <<-'GRAPHQL'
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
  		result = Waveapps::Client.query(DeleteInvoiceQuery, variables: {input: { id: id}})
			result.data
  	end
  end
end
