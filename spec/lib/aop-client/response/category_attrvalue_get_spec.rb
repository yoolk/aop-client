RSpec.describe AopClient::Response::CategoryAttrvalueGet, :with_rails do
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
