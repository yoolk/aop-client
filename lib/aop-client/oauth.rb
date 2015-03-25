module AopClient
  class OAuth

    ## Attributes
    attr_reader :config

    def initialize(code)
      @code   = code
      @config = Config.new
    end

    def exchange_code
      Request.post(
        url: config.oauth_entry,
        system_params: system_params,
        response_class: response_class
      )
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

    def response_class
      AopClient::Response::OAuth
    end

    private
      def timestamp_in_milliseconds
        (Time.now.to_f * 1000).to_i.to_s
      end

  end
end