require 'spec_helper'

describe "shelves/new" do
  before(:each) do
    assign(:shelf, stub_model(Shelf,
      :book_id => 1,
      :user_id => 1,
      :isbn13 => "MyString",
      :village_id => 1,
      :status => "MyString",
      :memo => "MyString",
      :history => "MyText"
    ).as_new_record)
  end

  it "renders new shelf form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shelves_path, :method => "post" do
      assert_select "input#shelf_book_id", :name => "shelf[book_id]"
      assert_select "input#shelf_user_id", :name => "shelf[user_id]"
      assert_select "input#shelf_isbn13", :name => "shelf[isbn13]"
      assert_select "input#shelf_village_id", :name => "shelf[village_id]"
      assert_select "input#shelf_status", :name => "shelf[status]"
      assert_select "input#shelf_memo", :name => "shelf[memo]"
      assert_select "textarea#shelf_history", :name => "shelf[history]"
    end
  end
end
