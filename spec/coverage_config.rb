if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'

    add_group 'Generators',   'lib/generators'
    add_group 'Validators',   'lib/validators'
    add_group 'Resources',    'lib/aop-client/resources'
    add_group 'Libraries',    'lib/aop-client'
  end
end