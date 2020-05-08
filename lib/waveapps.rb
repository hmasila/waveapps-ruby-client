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

  class Business

  	BusinessQuery = Waveapps::Client.parse <<-'GRAPHQL'
		  query($id: ID!) {
		    business(id: $id) {
		    	id
		    	name
		    	isPersonal
		    	isClassicAccounting
		      isClassicInvoicing
		    }
		  }
		GRAPHQL

		def self.get_business(id)
			result = Waveapps::Client.query(BusinessQuery, variables: {id: id})
			result.data.business
		end

		ListBusinessesQuery = Waveapps::Client.parse <<-'GRAPHQL'
		  query {
			  businesses(page: 1, pageSize: 10) {
			    pageInfo {
			      currentPage
			      totalPages
			      totalCount
			    }
			    edges {
			      node {
			        id
			        name
			        isClassicAccounting
			        isClassicInvoicing
			        isPersonal
			      }
			    }
			  }
			}
		GRAPHQL

  	def self.list_businesses
  		result = Waveapps::Client.query(ListBusinessesQuery).data
  		return [] if result.nil?
  		result.businesses.edges.map {|n| n.node}
  	end
  end

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
		# Waveapps::Invoice.create_invoice(business_id: "QnVzaW5lc3M6MWExOTYyOTAtZTQ5Yy00ZTIwLTg1NDAtZGY1MmZiMDIxMTI1", customer_id: "QnVzaW5lc3M6MWExOTYyOTAtZTQ5Yy00ZTIwLTg1NDAtZGY1MmZiMDIxMTI1O0N1c3RvbWVyOjM4OTIxODU3", items: [{product_id: "QnVzaW5lc3M6MWExOTYyOTAtZTQ5Yy00ZTIwLTg1NDAtZGY1MmZiMDIxMTI1O1Byb2R1Y3Q6NDM2NTQwNzA"}])
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

  class Account
  	FindValidIncomeAccountsQuery = Waveapps::Client.parse <<-'GRAPHQL'
  		query($id: ID!) {
			  business(id: $id) {
			    id
			    accounts(subtypes: [INCOME, DISCOUNTS, OTHER_INCOME]) {
			      edges {
			        node {
			          id
			          name
			          subtype {
			            name
			            value
			          }
			        }
			      }
			    }
			  }
			}
		GRAPHQL

		def self.find_valid_income_accounts(id)
			result = Waveapps::Client.query(FindValidIncomeAccountsQuery, variables: {id: id}).data
  		return nil if result.nil?
  		result.business.invoices.edegs.map {|n| n.node}
		end
  end

  class Product
  	ListProductsQuery = Waveapps::Client.parse <<-'GRAPHQL'
	  	query ($businessId: ID!, $page: Int!, $pageSize: Int!) {
			  business(id: $businessId) {
			    id
			    products(page: $page, pageSize: $pageSize) {
			      pageInfo {
			        currentPage
			        totalPages
			        totalCount
			      }
			      edges {
			        node {
			          id
			          name
			          description
			          unitPrice
			          defaultSalesTaxes {
			            id
			            name
			            abbreviation
			            rate
			          }
			          isSold
			          isBought
			          isArchived
			          createdAt
			          modifiedAt
			        }
			      }
			    }
			  }
			}
  	GRAPHQL

  	def self.list_products
  		result = Waveapps::Client.query(ListProductsQuery, variables: {id: id}).data
  		return nil if result.nil?
  		result.business.products.edegs.map {|n| n.node}
  	end

  	CreateProductQuery = Waveapps::Client.parse <<-'GRAPHQL'
  		mutation ($input: ProductCreateInput!) {
			  productCreate(input: $input) {
			    didSucceed
			    inputErrors {
			      code
			      message
			      path
			    }
			    product {
			      id
			      name
			      description
			      unitPrice
			      incomeAccount {
			        id
			        name
			      }
			      expenseAccount {
			        id
			        name
			      }
			      isSold
			      isBought
			      isArchived
			      createdAt
			      modifiedAt
			    }
			  }
			}
  	GRAPHQL

   	# {
		#   "input": {
		#     "businessId": "<BUSINESS_ID>",
		#     "name": "LED Bulb",
		#     "description": "5 Watt C7 light bulb",
		#     "unitPrice": "2.0625",
		#     "incomeAccountId": "<ACCOUNT_ID>"
		#   }
		# }

		def self.create_product(description: "", income_account_id: "", expense_account_id: "", default_sales_tax_ids: [], name: , business_id: , unit_price: )
			Waveapps::Client.query(CreateProductQuery, variables: { 
  			input: {
  				business_id: business_id,
  				name: name,
  				description: description,
  				unit_price: unit_price,
  				income_account_id: income_account_id,
  				expense_account_id: expense_account_id,
  				default_sales_tax_ids: default_sales_tax_ids
  			}
  		})
		end
  end

  class Customer
  	ListCustomersQuery = <<-'GRAPHQL'
  		query($id: ID!) {
			  business(id: $id) {
			    id
			    customers(page: 1, pageSize: 20, sort: [NAME_ASC]) {
			      pageInfo {
			        currentPage
			        totalPages
			        totalCount
			      }
			      edges {
			        node {
			          id
			          name
			          email
			        }
			      }
			    }
			  }
			}
  	GRAPHQL

  	def self.list_customers
  		result = Waveapps::Client.query(ListProductsQuery, variables: {id: id}).data
  		return nil if result.nil?
  		result.business.customers.edegs.map {|n| n.node}
  	end

  	CreateCustomerQuery = <<-'GRAPHQL'
  		mutation ($input: CustomerCreateInput!) {
			  customerCreate(input: $input) {
			    didSucceed
			    inputErrors {
			      code
			      message
			      path
			    }
			    customer {
			      id
			      name
			      firstName
			      lastName
			      email
			      address {
			        addressLine1
			        addressLine2
			        city
			        province {
			          code
			          name
			        }
			        country {
			          code
			          name
			        }
			        postalCode
			      }
			      currency {
			        code
			      }
			    }
			  }
			}
  	GRAPHQL

    # {
		#   "input": {
		#     "businessId": "<BUSINESS_ID>",
		#     "name": "Santa",
		#     "firstName": "Saint",
		#     "lastName": "Nicholas",
		#     "email": "santa@example.com",
		#     "address": {
		#       "city": "North Pole",
		#       "postalCode": "H0H 0H0",
		#       "provinceCode": "CA-NU",
		#       "countryCode": "CA"
		#     },
		#     "currency": "CAD"
		#   }
		# }

		def self.create_customer(first_name: "", last_name: "", address: {}, email: "", mobile: "", business_id: , name:)
			Waveapps::Client.query(CreateProductQuery, variables: { 
  			input: {
  				business_id: business_id,
  				name: name,
  				first_name: first_name,
  				last_name: last_name,
  				email: email,
  				mobile: mobile,
  				address: address
  			}
  		})
		end
  end
end

