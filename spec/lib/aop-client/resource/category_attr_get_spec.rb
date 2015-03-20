RSpec.describe AopClient::Resource::CategoryAttrGet do
  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

  it 'requires cat_id' do
    expect{
      described_class.new(cat_id: 0)
    }.not_to raise_error
  end

  it "attr_id format is '11,22'" do
    expect{
      described_class.new(cat_id: 0, attr_id: '111,222')
    }.not_to raise_error
  end

  describe '#request_params' do
    it 'when no attr_id' do
      expect(subject.request_params).to eq({ attribute_request: hash.to_json })
    end

    it 'else' do
      hash.merge!(attr_id: '111,222')

      expect(subject.request_params).to eq({ attribute_request: hash.to_json })
    end
  end
end