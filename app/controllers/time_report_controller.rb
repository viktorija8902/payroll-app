class TimeReportController < ApplicationController
  def index
    @payroll_report = PayrollReport.show_report
  end

  def save_file
    if user_params[:file]
      result = TimeReportProcessor.import(user_params[:file].path)
      if result == "Success"
        @success = "Report uploaded!"
      else
        @error = result
      end
    else
      @error = "Error: Please import csv file."
    end
    @payroll_report = PayrollReport.show_report
    render "index"
  end

  private
    def user_params
      params.permit(:file)
    end
end
