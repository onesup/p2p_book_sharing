require 'spec_helper'

describe "villages/show" do
  before(:each) do
    @village = assign(:village, stub_model(Village,
      :code => "Code",
      :si => "Si",
      :gu => "Gu",
      :dong => "Dong",
      :village => "Village"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Code/)
    rendered.should match(/Si/)
    rendered.should match(/Gu/)
    rendered.should match(/Dong/)
    rendered.should match(/Village/)
  end
end
