class HomeController < ApplicationController
  before_action :authenticate_user
  def top
    if @current_user
      redirect_to("/timetable")
    end
  end

  def redirect
    @onetime_year = Time.now.year
    @onetime_month = Time.now.month
    redirect_to("/timetable?date=#{@onetime_year}-#{@onetime_month}-01")
  end
  
end
