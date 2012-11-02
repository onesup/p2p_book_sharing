require 'spec_helper'

describe "collections/show" do
  before(:each) do
    @collection = assign(:collection, stub_model(Collection,
      :book_id => 1,
      :user_id => 2,
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
    rendered.should match(/3/)
    rendered.should match(/Status/)
    rendered.should match(/Memo/)
    rendered.should match(/MyText/)
  end
end
