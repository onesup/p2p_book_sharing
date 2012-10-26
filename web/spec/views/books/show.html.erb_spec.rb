require 'spec_helper'

describe "books/show" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/First Category/)
    rendered.should match(/Second Category/)
    rendered.should match(/Author/)
    rendered.should match(/Publisher/)
    rendered.should match(//)
    rendered.should match(/Language/)
    rendered.should match(/Size/)
    rendered.should match(/1/)
    rendered.should match(/Isbn10/)
    rendered.should match(/Isbn13/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Series/)
  end
end
