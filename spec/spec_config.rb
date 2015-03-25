$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
require 'coverage_config'
require 'pry'
require 'aop-client'
require 'generator_spec'
require 'vcr'
require 'webmock'

Dotenv.load

VCR.configure do |config|
  config.configure_rspec_metadata!
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_hosts 'coveralls.io'
  config.default_cassette_options = { record: :new_episodes }
end

def root_path(path = '')
  Pathname.new(File.join(File.dirname(__FILE__), path))
end

def open_file(file_name)
  File.open(Rails.root.join('images', file_name), 'rb')
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