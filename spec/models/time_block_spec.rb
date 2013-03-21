require 'spec_helper'

describe TimeBlock do
  let(:time_block) { build(:time_block) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:project_id) }
  
  it 'validates that the start_time is less than the end_time' do
    time_block.end_time = time_block.start_time - 1.day
    time_block.valid?.should be_false
  end

  it 'validates that the start_time does not equal end_time' do
    time_block.end_time = time_block.start_time
    time_block.valid?.should be_false
  end

  it 'has other time blocks regardless of persistence' do
    create(:time_block, user_id: time_block.user_id, project_id: time_block.project_id, 
      start_time: time_block.end_time + 1.second, end_time: time_block.end_time + 10.minutes)
    TimeBlock.count.should eql 1
    time_block.persisted?.should be_false
    time_block.other_time_blocks.should_not be_empty
    time_block.save.should be_true
    time_block.other_time_blocks.should_not be_empty
  end
  
  it 'can identify times between it\'s start and end times' do
    time_block.includes?(time_block.start_time - 1.second).should be_false
    time_block.includes?(time_block.start_time + 1.second).should be_true
    time_block.includes?(time_block.end_time - 1.second).should be_true
    time_block.includes?(time_block.end_time + 1.second).should be_false
  end

  it 'validates that time blocks do not overlap' do 
    time_block.save
    user_id = time_block.user_id
    project_id = time_block.project_id
    build(:time_block, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, start_time: time_block.start_time + 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, end_time: time_block.end_time - 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    
    build(:time_block, start_time: time_block.start_time + 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, end_time: time_block.end_time - 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time + 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
  end

  it 'validates that time blocks do not overlap with multiple other blocks' do 
    time_block.save
    user_id = time_block.user_id
    project_id = time_block.project_id
    create(:time_block, user_id: user_id, project_id: project_id, start_time: time_block.end_time + 2.seconds, end_time: time_block.end_time + 10.minutes).should be_true
    build(:time_block, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, start_time: time_block.start_time + 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, end_time: time_block.end_time - 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    build(:time_block, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).valid?.should be_false
    
    build(:time_block, start_time: time_block.start_time + 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, end_time: time_block.end_time - 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time + 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
    build(:time_block, start_time: time_block.start_time - 1.second, end_time: time_block.end_time + 1.second, user_id: user_id, project_id: project_id).
      valid?.should be_false
  end

  it 'knows how many seconds it has worked' do
    time_block.seconds_worked.should eql 600.0
  end
end
