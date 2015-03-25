module AopClient
  class API

    ## Attributes
    attr_reader :config, :alibaba_method, :system_params

    def initialize(access_token=nil)
      @api            = nil
      @system_params  = {}
      @alibaba_method = nil
      @config         = Config.new(access_token)
    end

    def call(alibaba_method, **args)
      @alibaba_method = alibaba_method
      @api            = alibaba_method_class.new(args)
      @system_params  = generate_system_params

      Request.post(
        url: config.api_entry,
        system_params: system_params,
        request_params: request_params,
        multipart_params: multipart_params,
        response_class: @api.response_class
      )
    end

    def alibaba_method_class
      return if alibaba_method.nil?

      "AopClient::Resource::#{alibaba_method.gsub('.', '_').classify}".constantize
    end

    def request_params
      @api.nil? ? {} : @api.request_params
    end

    def multipart_params
      @api.nil? ? {} : @api.multipart_params
    end

    private
      def timestamp_in_milliseconds
        (Time.now.to_f * 1000).to_i.to_s
      end

      def generate_system_params
        params = {
          v:            config.version,
          format:       config.format,
          app_key:      config.app_key,
          sign_method:  config.sign_method,
          timestamp:    timestamp_in_milliseconds,
          method:       "alibaba.icbu.#{alibaba_method}",
        }

        if @api.require_access_token?
          raise "#{alibaba_method} needs access_token!" if config.access_token.blank?

          params[:session] = config.access_token
        end

        params[:sign] = generate_sign(params)

        params
      end

      def generate_sign(params)
        params = params.clone.merge(request_params)
        params = params.sort.to_h
        fields = params.map {|a,b| "#{a}#{b}"}.join
        fields = config.app_secret + fields + config.app_secret

        Digest::MD5.hexdigest(fields).upcase
      end
  end
end