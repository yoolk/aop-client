RSpec.describe AopClient::Config do

  it 'require app_key, app_secret, api_entry', :with_rails do
    expect(subject.app_key).not_to      eq nil
    expect(subject.app_secret).not_to   eq nil
    expect(subject.api_entry).not_to    eq nil
    expect(subject.oauth_entry).not_to  eq nil
  end
end
