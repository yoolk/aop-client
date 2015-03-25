RSpec.describe AopClient::Resource::PhotobankUpload do
  describe 'validations' do
    it 'requires file_name' do
      expect{
        described_class.new(image_bytes: true, file_name: 'name.jpg')
      }.not_to raise_error
    end

    it 'file_name must be formated "name.jpg"' do
      expect{
        described_class.new(image_bytes: true, file_name: 'name.jpg')
      }.not_to raise_error
    end

    it 'unaccepted file_name formated "-.png"' do
      expect{
        described_class.new(image_bytes: true, file_name: '-.png')
      }.to raise_error.with_message(/File name is invalid/)
    end

    it 'unaccepted file_name formated pdf.pdf"' do
      expect{
        described_class.new(image_bytes: true, file_name: 'pdf.pdf')
      }.to raise_error.with_message(/File name is invalid/)
    end

    it 'requires image_bytes' do
      expect{
        described_class.new(image_bytes: true, file_name: 'name.jpg')
      }.not_to raise_error
    end

    it 'group_id must be numerirc' do
      expect{
        described_class.new(image_bytes: true, file_name: 'name.jpg', group_id: 1)
      }.not_to raise_error
    end

    it 'format_of extra_context' do
      validator = described_class.validators_on(:extra_context)[0]

      expect(validator).to be_a AopClient::CommaKeyValueValidator
      expect(validator.options).to eq({allow_blank: true, strict: true})
    end
  end

  describe 'instance methods' do
    let(:hash) do
      {
        image_bytes: true,
        file_name: 'name.jpg',
        group_id: 1,
        extra_context: 'key:value'
      }
    end
    subject { described_class.new(hash) }

    it '#request_params' do
      expect(subject.request_params).to eq(hash.except(:image_bytes))
    end

    it '#multipart_params' do
      expect(subject.multipart_params).to eq(hash.slice(:image_bytes))
    end

    it '#require_access_token?' do
      expect(subject.require_access_token?).to eq true
    end
  end

  describe 'responses scenario', :with_rails do
    let(:image) { open_file('test.png') }
    let(:hash)  { {} }
    let(:api)   { AopClient::API.new(ENV['ALIBABA_ACCESS_TOKEN']) }
    subject     { api.call('photobank.upload', hash) }

    it 'success response', vcr: { cassette_name: 'PhotobankUpload/Responses/Success' } do
      hash.merge!({ file_name: 'test.jpg', image_bytes: image })
      keys = [:file_name, :photobank_url]

      expect(subject.error).to be_nil
      expect(subject.data).to be_a Hash
      expect(subject.data.keys).to eq keys
    end

    fit 'invalid response', vcr: { cassette_name: 'PhotobankUpload/Responses/Invalid' } do
      hash.merge!({ file_name: 'test.jpg', image_bytes: true })

      expect(subject.data).to eq({})
      expect(subject.error[:code]).to     eq 25
      expect(subject.error[:msg]).to      eq 'Invalid signature'
      expect(subject.error[:request_id]).to be_present
    end
  end
end