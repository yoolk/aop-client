module AopClient
  class Config
    include ActiveModel::Validations

    ## Attributes
    attr_accessor :app_key
    attr_accessor :app_secret
    attr_accessor :api_entry

    ## Validations
    validates :app_key,     presence: true
    validates :app_secret,  presence: true
    validates :api_entry,   presence: true

    def initialize
      load_yml! if defined?(Rails) && yml_exists?
    end

    def yml_exists?
      defined?(Rails.root) ? File.exist?(yml_path) : false
    end

    def yml
      begin
        @yml ||= YAML.load(ERB.new(IO.read(yml_path)).result)[Rails.env] rescue nil || {}
      rescue Psych::SyntaxError
        @yml = {}
      end
    end

    def yml_path
      Rails.root.join('config', 'aop-client.yml').to_s
    end

    def load_yml!
      self.app_key    = yml['app_key']
      self.app_secret = yml['app_secret']
      self.api_entry  = yml['api_entry']
    end

  end
end
