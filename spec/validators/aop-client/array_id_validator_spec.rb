RSpec.describe AopClient::ArrayIdValidator do
  subject { ArrayIdValidatorTest.new }

  it 'unaccepted "A"' do
    expect {
      subject.value = 'A'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "A,a"' do
    expect {
      subject.value = 'A,a'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "1, 2"' do
    expect {
      subject.value = '1, 2'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted " 1,2"' do
    expect {
      subject.value = ' 1,2'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "1"' do
    expect {
      subject.value = '1'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "1,2"' do
    expect {
      subject.value = '1,2'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted "1,2,3"' do
    expect {
      subject.value = '1,2,3'
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted [1, 2, "b"]' do
    expect {
      subject.value = [1, 2, 'b']
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted [1, 2, 0]' do
    expect {
      subject.value = [1, 2, 0]
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'unaccepted [1, 2, -1]' do
    expect {
      subject.value = [1, 2, -1]
      subject.valid?
    }.to raise_error.with_message(/Value is invalid/)
  end

  it 'accepted [1]' do
    expect {
      subject.value = [1]
      subject.valid?
    }.not_to raise_error
  end

  it 'accepted [1, 2]' do
    expect {
      subject.value = [1, 2]
      subject.valid?
    }.not_to raise_error
  end

  private

  class ArrayIdValidatorTest
    include ActiveModel::Validations

    attr_accessor :value

    validates! :value, 'aop_client/array_id' => true
  end
end
