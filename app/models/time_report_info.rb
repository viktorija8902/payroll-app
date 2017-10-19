class TimeReportInfo < ApplicationRecord
  def self.get_grouped_reports
    self.select("employee_id, pay_period_start,
                 pay_period_end, job_group,
                 sum(hours_worked) as hours_worked")
        .group("employee_id", "pay_period_start", "pay_period_end")
  end
end
