require 'spec_helper'

describe "shelves/index" do
  before(:each) do
    assign(:shelves, [
      stub_model(Shelf,
        :book_id => 1,
        :user_id => 2,
        :isbn13 => "Isbn13",
        :village_id => 3,
        :status => "Status",
        :memo => "Memo",
        :history => "MyText"
      ),
      stub_model(Shelf,
        :book_id => 1,
        :user_id => 2,
        :isbn13 => "Isbn13",
        :village_id => 3,
        :status => "Status",
        :memo => "Memo",
        :history => "MyText"
      )
    ])
  end

  it "renders a list of shelves" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Isbn13".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Memo".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
