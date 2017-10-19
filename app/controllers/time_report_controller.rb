class TimeReportController < ApplicationController
  def index
    @payroll_report = PayrollReport.create_report
  end

  def save_file
    if TimeReportProcessor.import(user_params[:file].path) == "Success"
      @success = "Report uploaded!"
    else
      @error = "It is not allowed to upload the same report."
    end
    @payroll_report = PayrollReport.create_report
    render "index"
  end

  private
    def user_params
      params.permit(:file)
    end
end
