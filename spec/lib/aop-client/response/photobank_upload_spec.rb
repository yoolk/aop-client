RSpec.describe AopClient::Resource::PhotobankUpload, :with_rails do
  let(:image) { open_file('test.png') }
  let(:hash)  { {} }
  let(:api)   { AopClient::API.new(ENV['ALIBABA_ACCESS_TOKEN']) }
  subject     { api.call('photobank.upload', hash) }

  it 'success response', vcr: { cassette_name: 'PhotobankUpload/Responses/Success' } do
    hash.merge!({ file_name: 'test.jpg', image_bytes: image })
    keys = [:file_name, :photobank_url]

    expect(subject.error).to be_nil
    expect(subject.data).to be_a Hash
    expect(subject.data.keys).to eq keys
  end

  it 'invalid response', vcr: { cassette_name: 'PhotobankUpload/Responses/Invalid' } do
    hash.merge!({ file_name: 'test.jpg', image_bytes: true })

    expect(subject.data).to eq({})
    expect(subject.error[:code]).to     eq 25
    expect(subject.error[:msg]).to      eq 'Invalid signature'
    expect(subject.error[:request_id]).to be_present
  end
end