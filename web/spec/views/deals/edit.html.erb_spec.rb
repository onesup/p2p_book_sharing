require 'spec_helper'

describe "deals/edit" do
  before(:each) do
    @deal = assign(:deal, stub_model(Deal,
      :seller_id => "MyString",
      :buyer_id => "MyString",
      :collection_id => "MyString",
      :point => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit deal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => deals_path(@deal), :method => "post" do
      assert_select "input#deal_seller_id", :name => "deal[seller_id]"
      assert_select "input#deal_buyer_id", :name => "deal[buyer_id]"
      assert_select "input#deal_collection_id", :name => "deal[collection_id]"
      assert_select "input#deal_point", :name => "deal[point]"
      assert_select "input#deal_status", :name => "deal[status]"
    end
  end
end
