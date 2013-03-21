require "spec_helper"

describe TimeBlocksController do
  describe "routing" do

    it "routes to #index" do
      get("/time_blocks").should route_to("time_blocks#index")
    end

    it "routes to #new" do
      get("/time_blocks/new").should route_to("time_blocks#new")
    end

    it "routes to #show" do
      get("/time_blocks/1").should route_to("time_blocks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/time_blocks/1/edit").should route_to("time_blocks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/time_blocks").should route_to("time_blocks#create")
    end

    it "routes to #update" do
      put("/time_blocks/1").should route_to("time_blocks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/time_blocks/1").should route_to("time_blocks#destroy", :id => "1")
    end

  end
end
