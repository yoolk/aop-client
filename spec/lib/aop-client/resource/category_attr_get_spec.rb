RSpec.describe AopClient::Resource::CategoryAttrGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end

    it 'format_of attr_id' do
      validator = described_class.validators_on(:attr_id)[0]

      expect(validator).to be_a AopClient::CommaNumericValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
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