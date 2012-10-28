require 'spec_helper'

describe "list_pages/show" do
  before(:each) do
    @list_page = assign(:list_page, stub_model(ListPage,
      :url => "Url",
      :page => 1,
      :min_value => "Min Value",
      :max_value => "Max Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/1/)
    rendered.should match(/Min Value/)
    rendered.should match(/Max Value/)
  end
end
