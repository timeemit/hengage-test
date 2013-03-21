require 'spec_helper'

describe "time_blocks/edit" do
  before(:each) do
    @time_block = assign(:time_block, stub_model(TimeBlock))
  end

  it "renders the edit time_block form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", time_block_path(@time_block), "post" do
    end
  end
end
