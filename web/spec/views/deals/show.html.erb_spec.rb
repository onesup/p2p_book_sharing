require 'spec_helper'

describe "deals/show" do
  before(:each) do
    @deal = assign(:deal, stub_model(Deal,
      :seller_id => "Seller",
      :buyer_id => "Buyer",
      :collection_id => "Collection",
      :point => 1,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Seller/)
    rendered.should match(/Buyer/)
    rendered.should match(/Collection/)
    rendered.should match(/1/)
    rendered.should match(/Status/)
  end
end
