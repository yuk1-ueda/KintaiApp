class TimetablesController < ApplicationController
before_action :authenticate_user

  def search_table
    @year = params[:year]
    @month = params[:month]
    redirect_to("/timetable?date=#{@year}-#{@month}-01")
  end

  def index
    @timetables = calc_timetable
    @total_worktime = total_worktime
    @total_overtime = total_overtime
    # URLから取得した情報
    @date = params[:date]
  end

  def calc_timetable
    timetables = {}

    (Date.parse(params[:date]).beginning_of_month..Date.parse(params[:date]).end_of_month).each do |time|
      timetables[time] ||= {}

      @startofwork = Timecard.find_by(user_id: @current_user.id, startofwork: time.beginning_of_day...time.end_of_day ).try(:startofwork)
      timetables[time][:startofwork] = @startofwork

      @endofwork = Timecard.find_by(user_id: @current_user.id, endofwork: time.beginning_of_day...time.end_of_day ).try(:endofwork)
      timetables[time][:endofwork] = @endofwork

      # earlytime=10:00前の労働時間
      @ten_oclock = Time.parse("#{time.year}/#{time.month}/#{time.day} 10:00:00")
      if @startofwork && @startofwork < @ten_oclock
        @earlytime = TimeDifference.between(@startofwork, @ten_oclock).in_hours
      else
        @earlytime = nil
      end
      timetables[time][:earlytime] = @earlytime

      # gaptime=出勤時間と退勤時間の差
      if @startofwork && @endofwork && @earlytime
        @kousokutime = TimeDifference.between(@startofwork, @endofwork).in_hours
        @gaptime = @kousokutime - @earlytime
      elsif @startofwork && @endofwork
        @kousokutime = TimeDifference.between(@startofwork, @endofwork).in_hours
        @gaptime = @kousokutime
      else
        @gaptime = nil
      end
      timetables[time][:gaptime] = @gaptime
      
      # breaktime=休憩時間
      if @gaptime && @gaptime >= 5 && @gaptime < 10
        @breaktime = 1
      elsif @gaptime && @gaptime >= 10
        @breaktime = 2
      elsif @gaptime && @gaptime < 5
        @breaktime = 0
      else
        @breaktime = nil
      end
      timetables[time][:breaktime] = @breaktime

      # worktime=労働時間
      if @gaptime && @breaktime
        @worktime = @gaptime - @breaktime
      else
        @worktime = nil
      end
      timetables[time][:worktime] = @worktime

      # overtime=残業時間
      if @worktime && @worktime > 8
        @overtime = @worktime - 8
      else
        @overtime = 0
      end
      timetables[time][:overtime] = @overtime
    end
    timetables
  end

  def total_worktime
    total_worktime = 0
    @timetables.each do |key, value|
      if value[:worktime]
        total_worktime += value[:worktime]
      end
    end
    total_worktime
  end

  def total_overtime
    total_overtime = 0
    @timetables.each do |key, value|
      if value[:overtime]
        total_overtime += value[:overtime]
      end
    end
    total_overtime
  end


end