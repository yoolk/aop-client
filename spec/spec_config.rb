$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coverage_config'
require 'pry'
require 'aop-client'
require 'shoulda/matchers'
require 'generator_spec'

def root_path(path='')
  Pathname.new(File.join(File.dirname(__FILE__), path))
end

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir[root_path('tmp')])
  end

  config.before(:each) do |example|

    if example.metadata[:with_rails]
      Object.send(:remove_const, :Rails) if defined? Rails
      Rails = double('Rails')
      allow(Rails).to receive(:env).and_return('test')
      allow(Rails).to receive(:root).and_return(root_path('fixtures'))
    end

    if example.metadata[:without_rails]
      Object.send(:remove_const, :Rails) if defined? Rails
    end

    if example.metadata[:without_yml]
      allow(Rails).to receive(:root).and_return(root_path)
    end

  end
end