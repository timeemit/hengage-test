require 'spec_helper'

describe "time_blocks/index" do
  before(:each) do
    assign(:time_blocks, [
      stub_model(TimeBlock),
      stub_model(TimeBlock)
    ])
  end

  it "renders a list of time_blocks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
