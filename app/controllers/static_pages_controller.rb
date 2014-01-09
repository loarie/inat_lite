class StaticPagesController < ApplicationController
  def home
    if signed_in?
       if current_user.observations_count > 0
         @observations = Observation.find(:all, :from => "/observations/#{current_user.login}.json")
       end
    else
       render 'home_logged_out'
    end
  end
  
  def home_logged_out
  end

  def about
  end
end
