require "spec_helper"

describe PhotosController do
  describe "routing" do

    it "routes to #index" do
      get("api/photos").should route_to("photos#index")
    end

    it "routes to #new" do
      get("api/photos/new").should route_to("photos#new")
    end

    it "routes to #show" do
      get("api/photos/1").should route_to("photos#show", :id => "1")
    end

    it "routes to #edit" do
      get("api/photos/1/edit").should route_to("photos#edit", :id => "1")
    end

    it "routes to #create" do
      post("api/photos").should route_to("photos#create")
    end

    it "routes to #update" do
      put("api/photos/1").should route_to("photos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("api/photos/1").should route_to("photos#destroy", :id => "1")
    end

    it "routes to #webcam_create" do
      post("photos/webcam_create").should route_to("photos#webcam_create")
    end

    it "routes to #webcam" do
      get("photos/webcam").should route_to("photos#webcam")
    end

    it "routes to #upload" do
      post('photos/upload').should route_to('photos#upload')
    end

  end
end
