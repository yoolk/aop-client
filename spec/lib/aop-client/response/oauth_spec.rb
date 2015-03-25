RSpec.describe AopClient::Response::OAuth, :with_rails do
  it 'success response'

  it 'error response', vcr: { cassette_name: 'OAuth/Responses/Error' } do
    subject = AopClient::OAuth.new('code').exchange_code

    expect(subject.data).to be_nil
    expect(subject.error[:code]).to eq 'invalid_request'
    expect(subject.error[:msg]).to  eq 'response_type is empty'
  end
end
