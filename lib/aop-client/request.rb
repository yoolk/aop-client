module AopClient
  class Request

    ## Attributes
    attr_reader :url, :params, :body, :response_class

    def self.post(url, params, body, response_class)
      new(url, params, body, response_class).run
    end

    def initialize(url, params, body, response_class)
      @url    = url
      @params = params
      @body   = body
      @response_class = response_class
    end

    def run
      options = {
        headers: headers,
        params: params,
        body: body
      }

      response_class.new(Typhoeus.post(url, options))
    end

    def headers
      {
        'Content-type'  =>  'application/x-www-form-urlencoded; charset=UTF-8',
        'Cache-Control' =>  'no-cache',
        'Connection'    =>  'Keep-Alive'
      }
    end
  end
end