class ObservationsController < ApplicationController
  def show
    @observation = Observation.find(params[:id])
    @user = User.find(@observation.user_id)
  end
end
