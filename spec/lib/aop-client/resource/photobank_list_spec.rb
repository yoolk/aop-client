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

    it 'format_of extra_context' do
      validator = described_class.validators_on(:extra_context)[0]

      expect(validator).to be_a AopClient::CommaKeyValueValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
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

  it '#require_access_token?' do
    expect(subject.require_access_token?).to eq true
  end
end