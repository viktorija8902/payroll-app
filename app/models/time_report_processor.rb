require "csv"
require "date"

class TimeReportProcessor < ApplicationRecord
  def self.import(file)
    file = CSV.read(file, headers: true)
    last_row = file.delete(-1)
    report_id = last_row[1]
    if TimeReport.exists?(report_id: report_id)
      return "Error: It is not allowed to upload the same report."
    end
    TimeReport.create({"report_id": report_id})
    for row in file
      info = row.to_hash
      date_array = info["date"].split("/")
      day = date_array[0].to_i
      month = date_array[1].to_i
      year = date_array[2].to_i
      if day.between?(1, 15)
        pay_period_start = Date.new(year, month, 1)
        pay_period_end = Date.new(year, month, 15)
      else
        pay_period_start = Date.new(year, month, 16)
        pay_period_end = Date.new(year, month, -1)
      end
      TimeReportInfo.create!({
        "report_date": info["date"],
        "pay_period_start": pay_period_start,
        "pay_period_end": pay_period_end,
        "hours_worked": info["hours worked"],
        "employee_id": info["employee id"],
        "job_group": info["job group"],
        "report_id": report_id
      })
    end
    "Success"
  rescue
    "Error: Make sure that csv file is correct."
  end
end
