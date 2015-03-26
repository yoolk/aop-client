RSpec.describe AopClient::Resource::OpenProductPost do
  describe 'validations' do
    let(:hash) do
      {
        keywords: ['pencil', 'book'],
        subject: 'A Pencil Book',
        category_id: 145,
        product_image: true
      }
    end

    it 'requires keywords' do
      expect{
        described_class.new(hash)
      }.not_to raise_error
    end

    it 'requires subject' do
      expect{
        described_class.new(hash)
      }.not_to raise_error
    end

    it 'requires category_id' do
      expect{
        described_class.new(hash)
      }.not_to raise_error
    end

    it 'requires product_image' do
      expect{
        described_class.new(hash)
      }.not_to raise_error
    end

    it 'product_id must be id_like' do
      expect{
        described_class.new(hash.merge(product_id: 1))
      }.not_to raise_error
    end
  end

  describe 'instance methods' do
    let(:hash) do
      {
        subject: 'A Pencil Book',
        keywords: ['pencil', 'book'],
        category_id: 145,
        product_image: true,
        description: 'Good for drawing',
        group_id: 1,
        extra_context: 'key:value',
        product_id: 1,
        properties: [{ attr_id: 1 }]
      }
    end
    subject { described_class.new(hash) }

    it '#request_params' do
      expect(subject.request_params).to eq({ param_product_post: hash.to_json })
    end

    it '#require_access_token?' do
      expect(subject.require_access_token?).to eq true
    end
  end
end
