require 'csv'

CSV.generate do |csv|
    csv_column_names = %w(日付 出勤 退勤 労働時間 休憩時間 残業時間)
    csv << csv_column_names

    @timetables.each do |time, value|

        if value[:startofwork]
            @csv_startofwork = value[:startofwork].strftime("%H時%M分")
        else
            @csv_startofwork = nil
        end

        if value[:endofwork]
            @csv_endofwork = value[:endofwork].strftime("%H時%M分")
        else
            @csv_endofwork = nil
        end

        if value[:worktime]
            @csv_worktime_hour = value[:worktime] / 1
            @csv_worktime_min = value[:worktime] % 1 * 60
            @csv_worktime = "#{@csv_worktime_hour.floor}時間#{@csv_worktime_min.floor}分"
        else
            @csv_worktime = nil
        end

        csv_column_values = [
            time,
            @csv_startofwork,
            @csv_endofwork,
            @csv_worktime,
            value[:breaktime],
            value[:overtime]
        ]
        csv << csv_column_values
    end
end