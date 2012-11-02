require 'spec_helper'

describe "collections/new" do
  before(:each) do
    assign(:collection, stub_model(Collection,
      :book_id => 1,
      :user_id => 1,
      :village_id => 1,
      :status => "MyString",
      :memo => "MyString",
      :history => "MyText"
    ).as_new_record)
  end

  it "renders new collection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => collections_path, :method => "post" do
      assert_select "input#collection_book_id", :name => "collection[book_id]"
      assert_select "input#collection_user_id", :name => "collection[user_id]"
      assert_select "input#collection_village_id", :name => "collection[village_id]"
      assert_select "input#collection_status", :name => "collection[status]"
      assert_select "input#collection_memo", :name => "collection[memo]"
      assert_select "textarea#collection_history", :name => "collection[history]"
    end
  end
end
