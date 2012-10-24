require "spec_helper"

describe VillagesController do
  describe "routing" do

    it "routes to #index" do
      get("/villages").should route_to("villages#index")
    end

    it "routes to #new" do
      get("/villages/new").should route_to("villages#new")
    end

    it "routes to #show" do
      get("/villages/1").should route_to("villages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/villages/1/edit").should route_to("villages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/villages").should route_to("villages#create")
    end

    it "routes to #update" do
      put("/villages/1").should route_to("villages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/villages/1").should route_to("villages#destroy", :id => "1")
    end

  end
end
