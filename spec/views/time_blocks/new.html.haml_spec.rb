require 'spec_helper'

describe "time_blocks/new" do
  before(:each) do
    assign(:time_block, stub_model(TimeBlock).as_new_record)
  end

  it "renders new time_block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_blocks_path, "post" do
    end
  end
end
