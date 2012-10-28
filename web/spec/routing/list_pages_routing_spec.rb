require "spec_helper"

describe ListPagesController do
  describe "routing" do

    it "routes to #index" do
      get("/list_pages").should route_to("list_pages#index")
    end

    it "routes to #new" do
      get("/list_pages/new").should route_to("list_pages#new")
    end

    it "routes to #show" do
      get("/list_pages/1").should route_to("list_pages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/list_pages/1/edit").should route_to("list_pages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/list_pages").should route_to("list_pages#create")
    end

    it "routes to #update" do
      put("/list_pages/1").should route_to("list_pages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/list_pages/1").should route_to("list_pages#destroy", :id => "1")
    end

  end
end
