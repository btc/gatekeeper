require "spec_helper"

describe CommitteesController do
  describe "routing" do

    it "routes to #index" do
      get("api/committees").should route_to("committees#index")
    end

    it "routes to #new" do
      get("api/committees/new").should route_to("committees#new")
    end

    it "routes to #show" do
      get("api/committees/1").should route_to("committees#show", :id => "1")
    end

    it "routes to #edit" do
      get("api/committees/1/edit").should route_to("committees#edit", :id => "1")
    end

    it "routes to #create" do
      post("api/committees").should route_to("committees#create")
    end

    it "routes to #update" do
      put("api/committees/1").should route_to("committees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("api/committees/1").should route_to("committees#destroy", :id => "1")
    end

  end
end
