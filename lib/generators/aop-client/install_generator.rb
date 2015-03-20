require 'rails/generators'

module AopClient
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Install a config/aop-client.yml'

    def copy_initializer_file
      copy_file 'aop-client.yml', 'config/aop-client.yml'
    end

  end
end