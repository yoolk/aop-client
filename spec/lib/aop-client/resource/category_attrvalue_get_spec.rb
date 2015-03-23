RSpec.describe AopClient::Resource::CategoryAttrvalueGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end

    it 'attribute_id must be formated "1,2"' do
      expect{
        described_class.new(cat_id: 0, attribute_id: '1,2')
      }.not_to raise_error
    end

    it 'unaccepted attribute_id formated "A"' do
      expect{
        described_class.new(cat_id: 0, attribute_id: 'A')
      }.to raise_error.with_message(/Attribute is invalid/)
    end

    it 'unaccepted attribute_id formated "1, 2"' do
      expect{
        described_class.new(cat_id: 0, attribute_id: '1, 2')
      }.to raise_error.with_message(/Attribute is invalid/)
    end

    it 'attribute_value_id must be formated "1,2"' do
      expect{
        described_class.new(cat_id: 0, attribute_value_id: '1,2')
      }.not_to raise_error
    end

    it 'unaccepted attribute_value_id formated "A"' do
      expect{
        described_class.new(cat_id: 0, attribute_value_id: 'A')
      }.to raise_error.with_message(/Attribute value is invalid/)
    end

    it 'unaccepted attribute_value_id formated "1, 2"' do
      expect{
        described_class.new(cat_id: 0, attribute_value_id: '1, 2')
      }.to raise_error.with_message(/Attribute value is invalid/)
    end
  end

  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

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