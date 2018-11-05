class TimecardsController < ApplicationController
  before_action :authenticate_user


  def new
    @timecard = Timecard.new
  end

  def create_start
    @timecard = Timecard.new(
      user_id: @current_user.id,
      startofwork: Time.now,
      endofwork: nil
    ) 
    @timecard.save

    if @timecard.save
      flash[:notice] = "出勤打刻が完了しました"
      redirect_to("/timetable")
    else
      flash[:notice] = "出勤打刻が失敗しました"
      render("timecards/new")
    end
  end

  def create_end
    @timecard = Timecard.new(
      user_id: @current_user.id,
      startofwork: nil,
      endofwork: Time.now
    ) 
    @timecard.save

    if @timecard.save
      flash[:notice] = "退勤打刻が完了しました"
      redirect_to("/timetable")
    else
      flash[:notice] = "退勤打刻が失敗しました"
      render("timecards/new")
    end
  end
end
