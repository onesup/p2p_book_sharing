require 'spec_helper'

describe "list_pages/new" do
  before(:each) do
    assign(:list_page, stub_model(ListPage,
      :url => "MyString",
      :page => 1,
      :min_value => "MyString",
      :max_value => "MyString"
    ).as_new_record)
  end

  it "renders new list_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => list_pages_path, :method => "post" do
      assert_select "input#list_page_url", :name => "list_page[url]"
      assert_select "input#list_page_page", :name => "list_page[page]"
      assert_select "input#list_page_min_value", :name => "list_page[min_value]"
      assert_select "input#list_page_max_value", :name => "list_page[max_value]"
    end
  end
end
