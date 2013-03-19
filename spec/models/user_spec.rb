require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }

  it 'should have a default password of foobar' do
    FactoryGirl.create(:user).password.should eql 'foobar'
  end
end
