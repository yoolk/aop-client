RSpec.describe AopClient::Resource::CategoryAttrvalueGet do
  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

  it 'requires cat_id' do
    expect{
      described_class.new(cat_id: 0)
    }.not_to raise_error
  end

  it "attribute_id format is '11,22'" do
    expect{
      described_class.new(cat_id: 0, attribute_id: '111,222')
    }.not_to raise_error
  end

  it "attribute_value_id format is '11,22'" do
    expect{
      described_class.new(cat_id: 0, attribute_value_id: '111,222')
    }.not_to raise_error
  end

  describe '#request_params' do
    it 'when no attribute_id and attribute_value_id' do
      expect(subject.request_params).to eq({ attribute_value_request: hash.to_json })
    end

    it 'when has attribute_id' do
      hash.merge!(attribute_id: '111,222')

      expect(subject.request_params).to eq({ attribute_value_request: hash.to_json })
    end

    it 'when has attribute_value_id' do
      hash.merge!(attribute_value_id: '111,222')

      expect(subject.request_params).to eq({ attribute_value_request: hash.to_json })
    end

    it 'else' do
      hash.merge!(attribute_id: '111,222')
      hash.merge!(attribute_value_id: '111,222')

      expect(subject.request_params).to eq({ attribute_value_request: hash.to_json })
    end
  end
end