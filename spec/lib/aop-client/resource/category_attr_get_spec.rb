RSpec.describe AopClient::Resource::CategoryAttrGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end

    it 'attr_id must be formated "1,2"' do
      expect{
        described_class.new(cat_id: 0, attr_id: '1,2')
      }.not_to raise_error
    end

    it 'unaccepted extra_context formated "A"' do
      expect{
        described_class.new(cat_id: 0, attr_id: 'A')
      }.to raise_error.with_message(/Attr is invalid/)
    end

    it 'unaccepted extra_context formated "1, 2"' do
      expect{
        described_class.new(cat_id: 0, attr_id: '1, 2')
      }.to raise_error.with_message(/Attr is invalid/)
    end
  end

  let(:hash) { { cat_id: 0 } }
  subject    { described_class.new(hash) }

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