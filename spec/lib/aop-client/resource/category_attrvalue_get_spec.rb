RSpec.describe AopClient::Resource::CategoryAttrvalueGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end

    it 'format_of attribute_id' do
      validator = described_class.validators_on(:attribute_id)[0]

      expect(validator).to be_a AopClient::CommaNumericValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
    end

    it 'format_of attribute_value_id' do
      validator = described_class.validators_on(:attribute_value_id)[0]

      expect(validator).to be_a AopClient::CommaNumericValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
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