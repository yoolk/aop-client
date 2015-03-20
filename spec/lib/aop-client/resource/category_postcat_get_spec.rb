RSpec.describe AopClient::Resource::CategoryPostcatGet do
  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

  it 'requires cat_id' do
    expect{
      described_class.new(cat_id: 0)
    }.not_to raise_error
  end

  it '#request_params' do
    expect(subject.request_params).to eq({ post_cat_request: hash.to_json })
  end
end