class RepositoriesController < ApplicationController

  def search

  end

  def github_search
  	begin 
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['client_id'] = "d762399f79e948786e29"
      req.params['client_secret'] = "a16346f42ae27dcf535fe098836bb200fa2169b4"
      req.params['q'] = params[:query]
      #req.options.timeout = 10
    end
	  
	  body = JSON.parse(@resp.body)
	  if @resp.success?
	   @callback = body["items"]
	  else
	    @error = body["message"]
	  end

	rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
	render 'search'
  end
end
