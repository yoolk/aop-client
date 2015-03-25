RSpec.describe AopClient::Response::CategoryAttrGet, :with_rails do
  let(:hash) { {} }
  let(:api)  { AopClient::API.new }
  subject    { api.call('category.attr.get', hash) }

  it 'success response', vcr: { cassette_name: 'CategoryAttrGet/Responses/Success' } do
    hash.merge!({ cat_id: 145 })
    keys = [:attr_id, :catid, :cn_name, :en_name, :key_attr, :locator, :order,
      :parent_value, :required, :show_type]

    expect(subject.error).to be_nil
    expect(subject.data).to be_a Array
    expect(subject.data[0].keys).to eq keys
  end

  it 'not leaf response', vcr: { cassette_name: 'CategoryAttrGet/Responses/NotLeaf' } do
    hash.merge!({ cat_id: 1 })

    expect(subject.data).to eq []
    expect(subject.error[:code]).to     eq 15
    expect(subject.error[:msg]).to      eq 'Remote service error'
    expect(subject.error[:sub_code]).to eq 'isv.010002'
    expect(subject.error[:sub_msg]).to  eq 'input catid is not leaf category'
    expect(subject.error[:request_id]).to be_present
  end
end
