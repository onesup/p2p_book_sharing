require 'spec_helper'

describe "list_pages/index" do
  before(:each) do
    assign(:list_pages, [
      stub_model(ListPage,
        :url => "Url",
        :page => 1,
        :min_value => "Min Value",
        :max_value => "Max Value"
      ),
      stub_model(ListPage,
        :url => "Url",
        :page => 1,
        :min_value => "Min Value",
        :max_value => "Max Value"
      )
    ])
  end

  it "renders a list of list_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Min Value".to_s, :count => 2
    assert_select "tr>td", :text => "Max Value".to_s, :count => 2
  end
end
