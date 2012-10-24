require 'spec_helper'

describe "villages/index" do
  before(:each) do
    assign(:villages, [
      stub_model(Village,
        :code => "Code",
        :si => "Si",
        :gu => "Gu",
        :dong => "Dong",
        :village => "Village"
      ),
      stub_model(Village,
        :code => "Code",
        :si => "Si",
        :gu => "Gu",
        :dong => "Dong",
        :village => "Village"
      )
    ])
  end

  it "renders a list of villages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Si".to_s, :count => 2
    assert_select "tr>td", :text => "Gu".to_s, :count => 2
    assert_select "tr>td", :text => "Dong".to_s, :count => 2
    assert_select "tr>td", :text => "Village".to_s, :count => 2
  end
end
