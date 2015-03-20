if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'

    add_group 'Libraries',    'lib/aop-client'
    add_group 'Generators',   'lib/generators'
  end
end