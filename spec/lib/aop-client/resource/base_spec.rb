RSpec.describe AopClient::Resource::Base do
  it '#request_params' do
    expect(subject.request_params).to eq({})
  end

  it '#multipart_params' do
    expect(subject.multipart_params).to eq({})
  end

  it '#require_access_token?' do
    expect(subject.require_access_token?).to eq false
  end

  it '#response_class' do
    expect(subject.response_class).to eq AopClient::Response::Base
  end
end
