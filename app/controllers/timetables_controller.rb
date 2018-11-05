class TimetablesController < ApplicationController
before_action :authenticate_user
  def index
   @current_user_timecard = Timecard.where(user_id: session[:user_id])
  end

  def csv_output
    @csv_output = Timecard.find(user_id: @current_user.id)
  end
end
