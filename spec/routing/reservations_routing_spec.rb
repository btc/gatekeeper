require "spec_helper"

describe ReservationsController do
  describe "routing" do

    it "routes to #index" do
      get("api/reservations").should route_to("reservations#index")
    end

    it "routes to #new" do
      get("api/reservations/new").should route_to("reservations#new")
    end

    it "routes to #show" do
      get("api/reservations/1").should route_to("reservations#show", :id => "1")
    end

    it "routes to #edit" do
      get("api/reservations/1/edit").should route_to("reservations#edit", :id => "1")
    end

    it "routes to #create" do
      post("api/reservations").should route_to("reservations#create")
    end

    it "routes to #update" do
      put("api/reservations/1").should route_to("reservations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("api/reservations/1").should route_to("reservations#destroy", :id => "1")
    end

  end
end
