require 'spec_helper'

describe "book_urls/new" do
  before(:each) do
    assign(:book_url, stub_model(BookUrl,
      :url => "MyString",
      :title => "MyString",
      :author => "MyString"
    ).as_new_record)
  end

  it "renders new book_url form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => book_urls_path, :method => "post" do
      assert_select "input#book_url_url", :name => "book_url[url]"
      assert_select "input#book_url_title", :name => "book_url[title]"
      assert_select "input#book_url_author", :name => "book_url[author]"
    end
  end
end
