require 'spec_helper'

describe "book_urls/index" do
  before(:each) do
    assign(:book_urls, [
      stub_model(BookUrl,
        :url => "Url",
        :title => "Title",
        :author => "Author"
      ),
      stub_model(BookUrl,
        :url => "Url",
        :title => "Title",
        :author => "Author"
      )
    ])
  end

  it "renders a list of book_urls" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
  end
end
