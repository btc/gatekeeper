class RootController < ApplicationController
  def index
    authorize! :go, :home
  end
end
