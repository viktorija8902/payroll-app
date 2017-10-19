class PayrollReport < ApplicationRecord
  def self.show_report
    time_reports = TimeReportInfo.get_grouped_reports
    payroll_report = []
    for time_report in time_reports
      if time_report["job_group"] == "A"
        amount_paid = time_report["hours_worked"] * 20
      elsif time_report["job_group"] == "B"
        amount_paid = time_report["hours_worked"] * 30
      end
      payroll_row = {}
      payroll_row["employee_id"] = time_report["employee_id"]
      payroll_row["pay_period"] = time_report["pay_period_start"].strftime("%d/%m/%Y") +
                                  " - " +
                                  time_report["pay_period_end"].strftime("%d/%m/%Y")
      payroll_row["amount_paid"] = '%.2f' % amount_paid
      payroll_report << payroll_row
    end
    payroll_report
  end
end
