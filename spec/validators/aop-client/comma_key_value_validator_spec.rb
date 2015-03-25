RSpec.describe AopClient::CommaKeyValueValidator do

  subject { CommaKeyValueValidatorTest.new }

  it 'unaccepted "key: value"' do
    expect{
      subject.value = 'key: value'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "key:value:key"' do
    expect{
      subject.value = 'key:value:key'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "key: value"' do
    expect{
      subject.value = 'key: value'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted " key:value"' do
    expect{
      subject.value = ' key:value'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'accepted "key:value"' do
    expect{
      subject.value = 'key:value'
      subject.valid?
    }.not_to raise_error
  end

  it 'accepted "key:value,k:v"' do
    expect{
      subject.value = 'key:value,k:v'
      subject.valid?
    }.not_to raise_error
  end

  it 'accepted "key:value,k:v,m:v"' do
    expect{
      subject.value = 'key:value,k:v,m:v'
      subject.valid?
    }.not_to raise_error
  end

  private
    class CommaKeyValueValidatorTest
      include ActiveModel::Validations

      attr_accessor :value

      validates! :value, 'aop_client/comma_key_value' => true
    end
end
