module Waveapps
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
end
