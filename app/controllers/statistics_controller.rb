class StatisticsController < ApplicationController
  def index
    authorize! :read, :statistics
  end
end
