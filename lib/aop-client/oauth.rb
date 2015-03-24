module AopClient
  class OAuth

    ## Attributes
    attr_reader :config

    def initialize(code)
      @code   = code
      @config = Config.new
    end

    def exchange_code
      response = Typhoeus.post(config.oauth_entry, headers: headers, params: system_params)
      Response.new(response)
    end

    def system_params
      {
        client_id:     config.app_key,
        client_secret: config.app_secret,
        code:          @code,
        grant_type:    'authorization_code',
        view:          'web'
      }
    end

    private
      def timestamp_in_milliseconds
        (Time.now.to_f * 1000).to_i.to_s
      end

  end
end