RSpec.describe AopClient::Resource::CategoryPostcatGet, :with_rails do
  let(:hash) { {} }
  let(:api)  { AopClient::API.new }
  subject    { api.call('category.postcat.get', hash) }

  it 'success response', vcr: { cassette_name: 'CategoryPostcatGet/Responses/Success' } do
    hash.merge!({ cat_id: 0 })
    keys = [:cat_id, :child_ids, :cn_name, :en_name, :leaf_cat, :parent_ids]

    expect(subject.error).to be_nil
    expect(subject.data).to be_a Array
    expect(subject.data[0].keys).to eq keys
  end

  it 'not found response', vcr: { cassette_name: 'CategoryPostcatGet/Responses/NotFound' } do
    hash.merge!({ cat_id: 1000000000 })

    expect(subject.data).to eq []
    expect(subject.error[:code]).to     eq 15
    expect(subject.error[:msg]).to      eq 'Remote service error'
    expect(subject.error[:sub_code]).to eq 'isv.100000'
    expect(subject.error[:sub_msg]).to  eq 'category does not exist'
    expect(subject.error[:request_id]).to be_present
  end
end
