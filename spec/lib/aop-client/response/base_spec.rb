RSpec.describe AopClient::Response::Base do
  let(:response) { double('response', body: body.to_json) }
  subject { described_class.new(response) }

  context 'when error response' do
    let(:body) do
      {
        error_response: { code: 15, msg: 'Invalid signature' }
      }
    end

    it '#data' do
      expect(subject.data).to be_nil
    end

    it '#error' do
      expect(subject.error).to eq body[:error_response]
    end
  end

  context 'when success response' do
    let(:body) { { url: 'url', name: 'name' } }

    it '#data' do
      expect(subject.data).to eq body
    end

    it '#error' do
      expect(subject.error).to be_nil
    end
  end

  context 'when response body is not json' do
    let(:response) { double('response', body: '<title>Hello</title>') }

    it '#data' do
      expect(subject.data).to be_nil
    end

    it '#error' do
      expect(subject.error).to be_nil
    end
  end
end