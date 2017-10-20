class TimeReportInfo < ApplicationRecord
  validates :report_date, presence: true
  validates :pay_period_start, presence: true
  validates :pay_period_end, presence: true
  validates :hours_worked, presence: true
  validates :employee_id, presence: true
  validates :job_group, presence: true
  validates :report_id, presence: true

  def self.get_grouped_reports
    select("employee_id, pay_period_start,
                 pay_period_end, job_group,
                 sum(hours_worked) as hours_worked")
    .group("employee_id", "pay_period_start", "pay_period_end")
  end
end
