RSpec.describe AopClient::Resource::CategoryPostcatGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end
  end

  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

  it '#request_params' do
    expect(subject.request_params).to eq({ post_cat_request: hash.to_json })
  end

  it '#require_access_token?' do
    expect(subject.require_access_token?).to eq false
  end
end