require "csv"
require "date"

class TimeReportProcessor < ApplicationRecord
  def self.import(file)
    file = CSV.read(file, headers: true)
    last_row = file.delete(-1)
    report_id = last_row[1]
    ActiveRecord::Base.transaction do
      if TimeReport.exists?(report_id: report_id)
        return "Error: It is not allowed to upload the same report."
      end
      TimeReport.create({report_id: report_id})
      for row in file
        create_report_info(row, report_id)
      end
    end
    "Success"
  rescue
    "Error: Make sure that csv file is correct."
  end

  private

  def self.create_report_info(row, report_id)
    info = row.to_hash
    report_date = info["date"]
    pay_period = get_pay_period(report_date)
    TimeReportInfo.create!({
      report_date: report_date,
      pay_period_start: pay_period[:start],
      pay_period_end: pay_period[:end],
      hours_worked: info["hours worked"],
      employee_id: info["employee id"],
      job_group: info["job group"],
      report_id: report_id
    })
  end

  def self.get_pay_period(report_date)
    date_array = report_date.split("/")
    day = date_array[0].to_i
    month = date_array[1].to_i
    year = date_array[2].to_i
    pay_period = {}
    if day.between?(1, 15)
      pay_period[:start] = Date.new(year, month, 1)
      pay_period[:end] = Date.new(year, month, 15)
    else
      pay_period[:start] = Date.new(year, month, 16)
      pay_period[:end]= Date.new(year, month, -1)
    end
    pay_period
  end
end
