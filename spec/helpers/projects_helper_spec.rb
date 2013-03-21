require 'spec_helper'

describe ProjectsHelper do
  it 'converts seconds to hours and rounds appropriately' do
    helper.rounded_hours_from_seconds(60).should == 1.0
    helper.rounded_hours_from_seconds(70).should == 1.25
    helper.rounded_hours_from_seconds(80).should == 1.25
    helper.rounded_hours_from_seconds(90).should == 1.5
    helper.rounded_hours_from_seconds(100).should == 1.75
    helper.rounded_hours_from_seconds(110).should == 1.75
    helper.rounded_hours_from_seconds(120).should == 2.0
  end
end
