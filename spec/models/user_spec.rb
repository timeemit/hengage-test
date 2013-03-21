require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:time_blocks) }
  it { should have_many(:projects).through(:time_blocks) }

  it 'should not simple strings as emails' do 
    build(:user, :email => 'hello').valid?.should be_false
  end

  it 'should have a default password of foobar' do
    create(:user).password.should eql 'foobar'
  end
end
