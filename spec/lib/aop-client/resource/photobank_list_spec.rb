RSpec.describe AopClient::Resource::PhotobankList do
  describe 'validations' do
    it 'current_page must be numerirc' do
      expect{
        described_class.new(current_page: 1)
      }.not_to raise_error
    end

    it 'group_id must be numerirc' do
      expect{
        described_class.new(group_id: 1)
      }.not_to raise_error
    end

    it 'page_size must be numerirc' do
      expect{
        described_class.new(page_size: 1)
      }.not_to raise_error
    end

    it 'location_type must be in group' do
      expect{
        described_class.new(location_type: 'ALL_GROUP')
      }.not_to raise_error
    end

    it 'extra_context must be formated "key:value,k:v"' do
      expect{
        described_class.new(extra_context: 'key:value,k:v')
      }.not_to raise_error
    end

    it 'unaccepted extra_context formated "key: value"' do
      expect{
        described_class.new(extra_context: 'key: value')
      }.to raise_error.with_message(/Extra context is invalid/)
    end

    it 'unaccepted extra_context formated "key:value:key"' do
      expect{
        described_class.new(extra_context: 'key:value:key')
      }.to raise_error.with_message(/Extra context is invalid/)
    end

    it 'unaccepted extra_context formated " key:value"' do
      expect{
        described_class.new(extra_context: ' key:value')
      }.to raise_error.with_message(/Extra context is invalid/)
    end
  end

  let(:hash) { {} }
  subject    { described_class.new(hash) }

  describe '#request_params' do
    it 'when no attributes are set' do
      expect(subject.request_params).to eq(hash)
    end

    it 'else' do
      hash.merge!(current_page: 1)
      hash.merge!(group_id: 1)
      hash.merge!(page_size: 1)
      hash.merge!(location_type: 'SUB_GROUP')
      hash.merge!(extra_context: 'key:value')

      expect(subject.request_params).to eq(hash)
    end
  end
end