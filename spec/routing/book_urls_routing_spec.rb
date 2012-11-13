require "spec_helper"

describe BookUrlsController do
  describe "routing" do

    it "routes to #index" do
      get("/book_urls").should route_to("book_urls#index")
    end

    it "routes to #new" do
      get("/book_urls/new").should route_to("book_urls#new")
    end

    it "routes to #show" do
      get("/book_urls/1").should route_to("book_urls#show", :id => "1")
    end

    it "routes to #edit" do
      get("/book_urls/1/edit").should route_to("book_urls#edit", :id => "1")
    end

    it "routes to #create" do
      post("/book_urls").should route_to("book_urls#create")
    end

    it "routes to #update" do
      put("/book_urls/1").should route_to("book_urls#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/book_urls/1").should route_to("book_urls#destroy", :id => "1")
    end

  end
end
