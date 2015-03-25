RSpec.describe AopClient::OAuth, :with_rails do

  subject { described_class.new('code') }

  describe '#exchange_code' do
    it 'when success'
    xit 'when error' do
      response = subject.exchange_code

      expect(response.error).to be_present
      expect(response.error[:code]).to    eq 'invalid_request'
      expect(response.error[:message]).to eq 'response_type is empty'
    end
  end

  it '#system_params' do
    expect(subject.system_params[:code]).to       eq 'code'
    expect(subject.system_params[:grant_type]).to eq 'authorization_code'
    expect(subject.system_params[:view]).to       eq 'web'
    expect(subject.system_params[:client_id]).not_to     eq nil
    expect(subject.system_params[:client_secret]).not_to eq nil
  end
end