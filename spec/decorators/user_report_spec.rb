require 'spec_helper'

describe UserReport do
  let(:time_block) { create(:time_block) }
  let(:user) { time_block.user }
  let(:project) { time_block.project }
  let(:time_block_2) do
    create(:time_block, 
      user_id: user.id, project_id: project.id, start_time: time_block.start_time + 1.day, 
      end_time: time_block.end_time + 1.day + 20.minutes)
  end
  let(:project_2) { create(:project, :name => 'Goodbye!') }
  let(:time_block_3) { create(:time_block, user_id: user.id, project_id: project_2.id) }  
  
  before(:each) do
    time_block; time_block_2; time_block_3
  end
  
  def project_report
    attrs = {}
    attrs[:user_id] = user.id
    attrs[:start_time] = "2013-03-20 13:10:20".to_date.beginning_of_day
    attrs[:end_time] = "2013-03-20 13:10:20".to_date + 3.days
    
    UserReport.new(attrs)
  end
  
  it 'determines the projects effectively' do
    project_report.projects.include?(project)
    project_report.projects.include?(project_2)
    project_report.projects.length == 2
  end
  
  it 'collects the time blocks effectively' do
    project_report.time_blocks.include?(time_block)
    project_report.time_blocks.include?(time_block_2)
    project_report.time_blocks.include?(time_block_3)
    project_report.time_blocks.count == 3
  end
  
  it 'calculates the number of seconds worked by each employee correctly' do
    project_report.seconds_worked_for[project.id].should eql 2400.0
    project_report.seconds_worked_for[project_2.id].should eql 600.0
  end
end