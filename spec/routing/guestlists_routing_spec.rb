require "spec_helper"

describe GuestlistsController do
  describe "routing" do

    it "routes to #index" do
      get("api/guestlists").should route_to("guestlists#index")
    end

    it "routes to #new" do
      get("api/guestlists/new").should route_to("guestlists#new")
    end

    it "routes to #show" do
      get("api/guestlists/1").should route_to("guestlists#show", :id => "1")
    end

    it "routes to #edit" do
      get("api/guestlists/1/edit").should route_to("guestlists#edit", :id => "1")
    end

    it "routes to #create" do
      post("api/guestlists").should route_to("guestlists#create")
    end

    it "routes to #update" do
      put("api/guestlists/1").should route_to("guestlists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("api/guestlists/1").should route_to("guestlists#destroy", :id => "1")
    end

  end
end
