RSpec.describe AopClient::Resource::PhotobankList, :with_rails do
  let(:hash)  { {} }
  let(:api)   { AopClient::API.new(ENV['ALIBABA_ACCESS_TOKEN']) }
  subject     { api.call('photobank.list', hash) }

  it 'success response', vcr: { cassette_name: 'PhotobankList/Responses/Success' } do
    keys = [:url]

    expect(subject.error).to be_nil
    expect(subject.data).to be_a Array
    expect(subject.data[0].keys).to eq keys
  end
end