RSpec.describe AopClient::Resource::CategoryAttrvalueGet do
  describe 'validations' do
    it 'requires cat_id' do
      expect{
        described_class.new(cat_id: 0)
      }.not_to raise_error
    end

    it 'format_of attribute_id' do
      validator = described_class.validators_on(:attribute_id)[0]

      expect(validator).to be_a AopClient::ArrayIdValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
    end

    it 'format_of attribute_value_id' do
      validator = described_class.validators_on(:attribute_value_id)[0]

      expect(validator).to be_a AopClient::ArrayIdValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
    end
  end

  describe 'instance methods' do
    let(:hash) { { cat_id: 0, attribute_id: [1,2], attribute_value_id: [1,2] } }
    subject    { described_class.new(hash) }

    it '#request_params' do
      expect(subject.request_params).to eq({ attribute_value_request: hash.to_json })
    end

    it '#require_access_token?' do
      expect(subject.require_access_token?).to eq false
    end
  end
end
