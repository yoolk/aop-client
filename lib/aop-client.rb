require 'active_model'
require 'active_support'
require 'typhoeus'
require 'erb'
require 'yaml'

require 'validators/aop-client/comma_key_value_validator'
require 'validators/aop-client/comma_numeric_validator'

require 'aop-client/version'
require 'aop-client/config'
require 'aop-client/api'
require 'aop-client/oauth'
require 'aop-client/resource'
require 'aop-client/response'
require 'aop-client/request'

require 'generators/aop-client/install_generator' if defined?(Rails)