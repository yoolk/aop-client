RSpec.describe AopClient::Resource::OpenProductPost, :with_rails do
  let(:image_url) do
    'http://g02.s.alicdn.com/kf/UT8QN.rXhNbXXcUQpbXz/176473457/UT8QN.rXhNbXXcUQpbXz.png'
  end
  let(:hash)  do
    {
      keywords: ['pencil'],
      subject: 'A Pencil Book',
      category_id: 145,
      product_image: {
        image_file_list: [
          { image_file_url: image_url }
        ],
        image_watermark: false
      }
    }
  end
  let(:api)   { AopClient::API.new(ENV['ALIBABA_ACCESS_TOKEN']) }
  subject     { api.call('open.product.post', hash) }

  before do
    allow(api).to receive(:timestamp_in_milliseconds).and_return('1427340633031')
  end

  it 'success response', vcr: { cassette_name: 'OpenProductPost/Responses/Success' } do
    hash.merge!(properties: [
      {
        attr_name: 'Size',
        attr_name_id: 5,
        attr_value: 'Large',
        attr_value_id: 364944,
        inverval: false,
        unit: false
      }
    ])
    keys = [:product_id, :str_product_id, :request_id]

    expect(subject.error).to be_nil
    expect(subject.data).to be_a Hash
    expect(subject.data.keys).to eq keys
  end

  it 'invalid response', vcr: { cassette_name: 'OpenProductPost/Responses/Invalid' } do
    hash.merge!(category_id: 234)

    expect(subject.data).to eq({})
    expect(subject.error[:code]).to     eq 15
    expect(subject.error[:msg]).to      eq 'Remote service error'
    expect(subject.error[:sub_code]).to eq '100005'
    expect(subject.error[:sub_msg]).to  eq 'notHave'
    expect(subject.error[:request_id]).to be_present
  end
end