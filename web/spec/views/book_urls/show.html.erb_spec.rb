require 'spec_helper'

describe "book_urls/show" do
  before(:each) do
    @book_url = assign(:book_url, stub_model(BookUrl,
      :url => "Url",
      :title => "Title",
      :author => "Author"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    rendered.should match(/Title/)
    rendered.should match(/Author/)
  end
end
