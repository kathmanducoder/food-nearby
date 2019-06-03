class SearchesController < ApplicationController

  def search
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
        req.params['client_id'] = '1CKPP4AE2DRUMBZZUT3JWDRQJXUOLUBM341NRRUY2ONNX2V4'
        req.params['client_secret'] = 'HJDYSJLLQHLGVDZJFNAM5TUQEYI4VT3BQA0VPECJNO4UIDJA'
        req.params['v'] = '20160201'
        req.params['near'] = params[:query]
        req.params['query'] = 'restaurants'
      end

      body = JSON.parse(@resp.body)
      if @resp.success?
        @venues = body["response"]["venues"]
      else
        @error = body["meta"]["errorDetail"]
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'index'
  end

end
