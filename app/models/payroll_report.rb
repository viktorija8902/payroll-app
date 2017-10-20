class PayrollReport < ApplicationRecord
  GROUP_A_HOURLY_WAGE = 20
  GROUP_B_HOURLY_WAGE = 30

  def self.show_report
    time_reports = TimeReportInfo.get_grouped_reports
    self.form_payroll_report(time_reports)
  end

  private

  def self.form_payroll_report(time_reports)
    payroll_report = []
    for time_report in time_reports
      amount_paid = self.get_amount_paid(
                            time_report[:job_group],
                            time_report[:hours_worked]
      )
      payroll_row = self.form_payroll_row(
                            time_report[:employee_id],
                            time_report[:pay_period_start],
                            time_report[:pay_period_end],
                            amount_paid
      )
      payroll_report << payroll_row
    end
    payroll_report
  end

  def self.get_amount_paid(job_group, hours_worked)
    if job_group == "A"
      hours_worked * GROUP_A_HOURLY_WAGE
    elsif job_group == "B"
      hours_worked * GROUP_B_HOURLY_WAGE
    end
  end

  def self.form_payroll_row(employee_id, period_start, period_end, amount_paid)
    {
      employee_id: employee_id,
      amount_paid: "%.2f" % amount_paid,
      pay_period: period_start.strftime("%d/%m/%Y") + " - " +
                  period_end.strftime("%d/%m/%Y")
    }
  end
end
