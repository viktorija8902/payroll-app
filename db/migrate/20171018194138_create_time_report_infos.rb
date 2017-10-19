class CreateTimeReportInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :time_report_infos do |t|
      t.date :report_date
      t.date :pay_period_start
      t.date :pay_period_end
      t.decimal :hours_worked
      t.integer :employee_id
      t.string :job_group
      t.integer :report_id

      t.timestamps
    end
  end
end
