require 'spec_helper'

describe "shelves/show" do
  before(:each) do
    @shelf = assign(:shelf, stub_model(Shelf,
      :book_id => 1,
      :user_id => 2,
      :isbn13 => "Isbn13",
      :village_id => 3,
      :status => "Status",
      :memo => "Memo",
      :history => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Isbn13/)
    rendered.should match(/3/)
    rendered.should match(/Status/)
    rendered.should match(/Memo/)
    rendered.should match(/MyText/)
  end
end
