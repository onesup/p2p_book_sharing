require 'spec_helper'

describe "books/edit" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "MyString",
      :first_category => "MyString",
      :second_category => "MyString",
      :author => "MyString",
      :publisher => "MyString",
      :published_at => "",
      :language => "MyString",
      :size => "MyString",
      :last_page => 1,
      :isbn10 => "MyString",
      :isbn13 => "MyString",
      :price => 1,
      :reviewed => 1,
      :description => "MyText",
      :index => "MyText",
      :series => "MyString"
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path(@book), :method => "post" do
      assert_select "input#book_title", :name => "book[title]"
      assert_select "input#book_first_category", :name => "book[first_category]"
      assert_select "input#book_second_category", :name => "book[second_category]"
      assert_select "input#book_author", :name => "book[author]"
      assert_select "input#book_publisher", :name => "book[publisher]"
      assert_select "input#book_published_at", :name => "book[published_at]"
      assert_select "input#book_language", :name => "book[language]"
      assert_select "input#book_size", :name => "book[size]"
      assert_select "input#book_last_page", :name => "book[last_page]"
      assert_select "input#book_isbn10", :name => "book[isbn10]"
      assert_select "input#book_isbn13", :name => "book[isbn13]"
      assert_select "input#book_price", :name => "book[price]"
      assert_select "input#book_reviewed", :name => "book[reviewed]"
      assert_select "textarea#book_description", :name => "book[description]"
      assert_select "textarea#book_index", :name => "book[index]"
      assert_select "input#book_series", :name => "book[series]"
    end
  end
end
