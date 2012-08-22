class RootController < ApplicationController
  layout 'resources'
  def index
    authorize! :go, :home
  end
end
