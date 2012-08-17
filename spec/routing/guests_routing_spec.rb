require "spec_helper"

describe GuestsController do
  describe "routing" do

    it "routes to #index" do
      get("api/guests").should route_to("guests#index")
    end

    it "routes to #new" do
      get("api/guests/new").should route_to("guests#new")
    end

    it "routes to #show" do
      get("api/guests/1").should route_to("guests#show", :id => "1")
    end

    it "routes to #edit" do
      get("api/guests/1/edit").should route_to("guests#edit", :id => "1")
    end

    it "routes to #create" do
      post("api/guests").should route_to("guests#create")
    end

    it "routes to #update" do
      put("api/guests/1").should route_to("guests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("api/guests/1").should route_to("guests#destroy", :id => "1")
    end

  end
end
