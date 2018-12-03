require 'csv'

CSV.generate do |csv|
    csv_column_names = %w(日付 出勤 退勤 労働時間 休憩時間 残業時間)
    csv << csv_column_names

    @timetables.each do |time, value|

        if value[:startofwork]
            @csv_startofwork = value[:startofwork].strftime("%H:%M")
        else
            @csv_startofwork = nil
        end

        if value[:endofwork]
            @csv_endofwork = value[:endofwork].strftime("%H:%M")
        else
            @csv_endofwork = nil
        end

        if value[:worktime]
            @csv_worktime_hour = value[:worktime] / 1
            @csv_worktime_min = value[:worktime] % 1 * 60
            @csv_worktime = "#{@csv_worktime_hour.floor}:#{@csv_worktime_min.floor}"
        else
            @csv_worktime = nil
        end

        if value[:breaktime]
            @csv_breaktime_hour = value[:breaktime] / 1
            @csv_breaktime_min = value[:breaktime] % 1 * 60
            @csv_breaktime = "#{@csv_breaktime_hour.floor}:#{@csv_breaktime_min.floor}"
        else
            @csv_breaktime = nil
        end

        if value[:overtime]
            @csv_overtime_hour = value[:overtime] / 1
            @csv_overtime_min = value[:overtime] % 1 * 60
            @csv_overtime = "#{@csv_overtime_hour.floor}:#{@csv_overtime_min.floor}:"
        else
            @csv_overtime = nil
        end

        csv_column_values = [
            time,
            @csv_startofwork,
            @csv_endofwork,
            @csv_worktime,
            @csv_breaktime,
            @csv_overtime
        ]
        csv << csv_column_values
    end
end
