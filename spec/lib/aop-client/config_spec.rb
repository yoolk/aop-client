RSpec.describe AopClient::Config do

  it 'require app_key, app_secret, api_entry', :with_rails do
    expect{
      subject = described_class.new
    }.not_to raise_error

    expect(subject.app_key).to    eq 'test_app_key'
    expect(subject.app_secret).to eq 'test_app_secret'
    expect(subject.api_entry).to  eq 'test_api_entry'
  end
end
