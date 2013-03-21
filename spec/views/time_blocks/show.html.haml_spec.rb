require 'spec_helper'

describe "time_blocks/show" do
  before(:each) do
    @time_block = assign(:time_block, stub_model(TimeBlock))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
