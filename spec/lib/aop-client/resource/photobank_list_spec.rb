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

  describe 'instance methods' do
    let(:hash) do
      {
        current_page: 1,
        group_id: 1,
        location_type: 'SUB_GROUP',
        extra_context: 'key:value'
      }
    end
    subject    { described_class.new(hash) }

    it '#request_params' do
      expect(subject.request_params).to eq(hash)
    end

    it '#require_access_token?' do
      expect(subject.require_access_token?).to eq true
    end
  end
end
