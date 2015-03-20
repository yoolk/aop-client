module AopClient
  class API

    ## Attributes
    attr_reader :config

    def initialize(access_token=nil)
      @config = Config.new(access_token)
    end

    def call(alibaba_method, **args)
      klass = "AopClient::Resource::#{alibaba_method.gsub('.', '_').classify}".constantize
      klass.new(args)
    end

  end
end