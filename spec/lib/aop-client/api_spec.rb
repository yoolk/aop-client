RSpec.describe AopClient::API, :with_rails do

  it '#config' do
    expect(subject.config).to be_a AopClient::Config
  end

  it '#system_params' do
    expect(subject.system_params).to eq({})
  end

  it '#request_params' do
    expect(subject.request_params).to eq({})
  end

  it '#multipart_params' do
    expect(subject.multipart_params).to eq({})
  end

  it '#alibaba_method_class' do
    expect(subject.alibaba_method_class).to eq nil
  end
end