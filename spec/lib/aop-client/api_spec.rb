RSpec.describe AopClient::API, :with_rails do

  it '#config' do
    expect(subject.config).to be_a AopClient::Config
  end

  describe '#call' do
    it 'category.postcat.get' do
      hash = { cat_id: 0 }
      expect(AopClient::Resource::CategoryPostcatGet).to receive(:new).with(hash).and_call_original

      subject.call('category.postcat.get', hash)
    end

    it 'category.attr.get' do
      hash = { cat_id: 0, attr_id: '111,222' }
      expect(AopClient::Resource::CategoryAttrGet).to receive(:new).with(hash).and_call_original

      subject.call('category.attr.get', hash)
    end

    it 'category.attrvalue.get' do
      hash = { cat_id: 0, attribute_id: '111,222', attribute_value_id: '111,222' }
      expect(AopClient::Resource::CategoryAttrvalueGet).to receive(:new).with(hash).and_call_original

      subject.call('category.attrvalue.get', hash)
    end

    it 'photobank.list' do
      hash = { extra_context: 'key=value', current_page: 1, group_id: 1,
        location_type: 'ALL_GROUP', page_size: 20 }
      expect(AopClient::Resource::PhotobankList).to receive(:new).with(hash).and_call_original

      subject.call('photobank.list', hash)
    end

    it 'photobank.upload'
    it 'open.product.post'
  end
end