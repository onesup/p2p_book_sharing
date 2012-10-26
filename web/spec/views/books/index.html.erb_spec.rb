require 'spec_helper'

describe "books/index" do
  before(:each) do
    assign(:books, [
      stub_model(Book,
        :title => "Title",
        :first_category => "First Category",
        :second_category => "Second Category",
        :author => "Author",
        :publisher => "Publisher",
        :published_at => "",
        :language => "Language",
        :size => "Size",
        :last_page => 1,
        :isbn10 => "Isbn10",
        :isbn13 => "Isbn13",
        :price => 2,
        :reviewed => 3,
        :description => "MyText",
        :index => "MyText",
        :series => "Series"
      ),
      stub_model(Book,
        :title => "Title",
        :first_category => "First Category",
        :second_category => "Second Category",
        :author => "Author",
        :publisher => "Publisher",
        :published_at => "",
        :language => "Language",
        :size => "Size",
        :last_page => 1,
        :isbn10 => "Isbn10",
        :isbn13 => "Isbn13",
        :price => 2,
        :reviewed => 3,
        :description => "MyText",
        :index => "MyText",
        :series => "Series"
      )
    ])
  end

  it "renders a list of books" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "First Category".to_s, :count => 2
    assert_select "tr>td", :text => "Second Category".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Publisher".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Language".to_s, :count => 2
    assert_select "tr>td", :text => "Size".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Isbn10".to_s, :count => 2
    assert_select "tr>td", :text => "Isbn13".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Series".to_s, :count => 2
  end
end
