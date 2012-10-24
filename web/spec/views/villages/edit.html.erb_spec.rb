require 'spec_helper'

describe "villages/edit" do
  before(:each) do
    @village = assign(:village, stub_model(Village,
      :code => "MyString",
      :si => "MyString",
      :gu => "MyString",
      :dong => "MyString",
      :village => "MyString"
    ))
  end

  it "renders the edit village form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => villages_path(@village), :method => "post" do
      assert_select "input#village_code", :name => "village[code]"
      assert_select "input#village_si", :name => "village[si]"
      assert_select "input#village_gu", :name => "village[gu]"
      assert_select "input#village_dong", :name => "village[dong]"
      assert_select "input#village_village", :name => "village[village]"
    end
  end
end
