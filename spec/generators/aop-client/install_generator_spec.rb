RSpec.describe AopClient::InstallGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'creates config/aop-client.yml' do
    config_file = root_path('tmp/config/aop-client.yml')

    expect(config_file).to exist

    content = YAML.load(ERB.new(IO.read(config_file)).result)

    expect(content['development'].keys).to  eq %w(app_key app_secret api_entry)
    expect(content['test'].keys).to         eq %w(app_key app_secret api_entry)
    expect(content['production'].keys).to   eq %w(app_key app_secret api_entry)
  end
end