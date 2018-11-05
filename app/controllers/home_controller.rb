class HomeController < ApplicationController
  before_action :authenticate_user
  def top
    if @current_user
      redirect_to("/timetable")
    end
  end
end
