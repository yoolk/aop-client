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

  describe 'responses scenario', :with_rails do
    let(:hash) { {} }
    let(:api)  { AopClient::API.new }
    subject    { api.call('category.attrvalue.get', hash) }

    it 'success response', vcr: { cassette_name: 'CategoryAttrvalueGet/Responses/Success' } do
      hash.merge!({ cat_id: 145 })
      keys = [:attr_id, :attr_value_id, :cat_id, :en_name]

      expect(subject.error).to be_nil
      expect(subject.data).to be_a Array
      expect(subject.data[0].keys).to eq keys
    end

    it 'attr not found response', vcr: { cassette_name: 'CategoryAttrvalueGet/Responses/AttrNotFound' } do
      hash.merge!({ cat_id: 145, attribute_id: [1,2] })

      expect(subject.data).to eq []
      expect(subject.error[:code]).to     eq 15
      expect(subject.error[:msg]).to      eq 'Remote service error'
      expect(subject.error[:sub_code]).to eq 'isv.300000'
      expect(subject.error[:sub_msg]).to  eq 'attribute value does not exist'
      expect(subject.error[:request_id]).to be_present
    end
  end
end