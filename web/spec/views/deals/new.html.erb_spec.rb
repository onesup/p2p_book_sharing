require 'spec_helper'

describe "deals/new" do
  before(:each) do
    assign(:deal, stub_model(Deal,
      :seller_id => "MyString",
      :buyer_id => "MyString",
      :collection_id => "MyString",
      :point => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new deal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deals_path, :method => "post" do
      assert_select "input#deal_seller_id", :name => "deal[seller_id]"
      assert_select "input#deal_buyer_id", :name => "deal[buyer_id]"
      assert_select "input#deal_collection_id", :name => "deal[collection_id]"
      assert_select "input#deal_point", :name => "deal[point]"
      assert_select "input#deal_status", :name => "deal[status]"
    end
  end
end
