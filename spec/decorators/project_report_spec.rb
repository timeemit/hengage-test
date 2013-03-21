require 'spec_helper'

describe ProjectReport do
  let(:time_block) { create(:time_block) }
  let(:user) { time_block.user }
  let(:project) { time_block.project }
  let(:time_block_2) do
    create(:time_block, 
      user_id: user.id, project_id: project.id, start_time: time_block.start_time + 1.day, 
      end_time: time_block.end_time + 1.day + 20.minutes)
  end
  let(:admin) { create(:admin) }
  let(:time_block_3) { create(:time_block, user_id: admin.id, project_id: project.id) }  
  
  before(:each) do
    time_block; time_block_2; time_block_3
  end
  
  def project_report
    attrs = {}
    attrs[:project_id] = project.id
    attrs[:start_time] = "2013-03-20 13:10:20".to_date.beginning_of_day
    attrs[:end_time] = "2013-03-20 13:10:20".to_date + 3.days
    
    ProjectReport.new(attrs)
  end
  
  it 'determines the users effectively' do
    project_report.users.include?(user)
    project_report.users.include?(admin)
    project_report.users.length == 2
  end
  
  it 'collects the time blocks effectively' do
    project_report.time_blocks.include?(time_block)
    project_report.time_blocks.include?(time_block_2)
    project_report.time_blocks.include?(time_block_3)
    project_report.time_blocks.count == 3
  end
  
  it 'calculates the number of seconds worked by each employee correctly' do
    project_report.seconds_for[user.id].should eql 2400.0
    project_report.seconds_for[admin.id].should eql 600.0
  end
end