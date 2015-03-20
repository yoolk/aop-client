RSpec.describe AopClient::Config do
  it { is_expected.to validate_presence_of(:app_key) }
  it { is_expected.to validate_presence_of(:app_secret) }
  it { is_expected.to validate_presence_of(:api_entry) }

  describe '#initialize' do
    it 'when no Rails defined' do
      expect(subject.app_key).to    eq nil
      expect(subject.app_secret).to eq nil
      expect(subject.api_entry).to  eq nil
    end

    it 'when Rails defined but no yml file', :with_rails, :without_yml do
      expect(subject.app_key).to    eq nil
      expect(subject.app_secret).to eq nil
      expect(subject.api_entry).to  eq nil
    end

    it 'when Rails defined and yml file exist', :with_rails do
      expect(subject.app_key).to    eq 'test_app_key'
      expect(subject.app_secret).to eq 'test_app_secret'
      expect(subject.api_entry).to  eq 'test_api_entry'
    end
  end
end
