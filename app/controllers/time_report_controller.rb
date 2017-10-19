class TimeReportController < ApplicationController
  #TODO refactor
  def index
    @time_reports = TimeReportInfo
      .select("employee_id, pay_period_start, pay_period_end, job_group, sum(hours_worked) as hours_worked")
      .group("employee_id", "pay_period_start", "pay_period_end")
    @payroll_report = []
    for time_report in @time_reports
      if time_report["job_group"] == "A"
        amount_paid = time_report["hours_worked"] * 20
      elsif time_report["job_group"] == "B"
        amount_paid = time_report["hours_worked"] * 30
      end
      payroll_row = {}
      payroll_row["employee_id"] = time_report["employee_id"]
      payroll_row["pay_period"] = time_report["pay_period_start"].strftime("%d/%m/%Y") + " - " + time_report["pay_period_end"].strftime("%d/%m/%Y")
      payroll_row["amount_paid"] = '%.2f' % amount_paid
      @payroll_report << payroll_row
    end
    @payroll_report
  end

  def save_file
    if TimeReportProcessor.import(user_params[:file].path) == "Success"
      @success = "Report uploaded!"
    else
      @error = "It is not allowed to upload the same report."
    end
    #TODO show payroll report: job group A is paid $20/hr, and job group B is paid $30/hr
    @time_reports = TimeReportInfo.group("employee_id", "pay_period_start").sum("hours_worked")
    render "index"
  end

  private
    def user_params
      params.permit(:file)
    end
end
