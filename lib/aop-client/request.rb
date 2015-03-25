module AopClient
  class Request
    def self.post(options = {})
      new(options).run
    end

    def initialize(options = {})
      @url                = options[:url]
      @response_class     = options[:response_class]
      @params             = options[:system_params] || {}
      @request_params     = options[:request_params] || {}
      @multipart_params   = options[:multipart_params] || {}
      @body               = @request_params.merge(@multipart_params)

      set_headers
    end

    def run
      options = {
        headers: @headers,
        params: @params,
        body: @body
      }

      @response_class.new(Typhoeus.post(@url, options))
    end

    private

    def set_headers
      @headers = {
        'Content-type'  =>  'application/x-www-form-urlencoded; charset=UTF-8',
        'Cache-Control' =>  'no-cache',
        'Connection'    =>  'Keep-Alive'
      }

      @headers.delete('Content-type') if @multipart_params.present?
    end
  end
end
