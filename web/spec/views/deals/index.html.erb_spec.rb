require 'spec_helper'

describe "deals/index" do
  before(:each) do
    assign(:deals, [
      stub_model(Deal,
        :seller_id => "Seller",
        :buyer_id => "Buyer",
        :collection_id => "Collection",
        :point => 1,
        :status => "Status"
      ),
      stub_model(Deal,
        :seller_id => "Seller",
        :buyer_id => "Buyer",
        :collection_id => "Collection",
        :point => 1,
        :status => "Status"
      )
    ])
  end

  it "renders a list of deals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Seller".to_s, :count => 2
    assert_select "tr>td", :text => "Buyer".to_s, :count => 2
    assert_select "tr>td", :text => "Collection".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
