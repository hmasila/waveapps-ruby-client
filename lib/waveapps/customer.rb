module Waveapps
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
