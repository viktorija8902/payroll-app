class TimeReportController < ApplicationController
  #TODO show payroll report: job group A is paid $20/hr, and job group B is paid $30/hr
  def index
    @time_reports = TimeReportInfo.group("employee_id", "pay_period_start").sum("hours_worked")
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
