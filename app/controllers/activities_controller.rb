class ActivitiesController < ApplicationController

  def index
    @user = Activity.grab_user
    @activities = Activity.grab_activities
  end

end
