RSpec.describe AopClient::OAuth, :with_rails do
  subject { described_class.new('code') }

  it '#system_params' do
    expect(subject.system_params[:code]).to       eq 'code'
    expect(subject.system_params[:grant_type]).to eq 'authorization_code'
    expect(subject.system_params[:view]).to       eq 'web'
    expect(subject.system_params[:client_id]).not_to     eq nil
    expect(subject.system_params[:client_secret]).not_to eq nil
  end

  it '#response_class' do
    expect(subject.response_class).to eq AopClient::Response::OAuth
  end
end
