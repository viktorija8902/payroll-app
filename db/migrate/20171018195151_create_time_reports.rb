class CreateTimeReports < ActiveRecord::Migration[5.1]
  def change
    create_table :time_reports do |t|
      t.integer :report_id

      t.timestamps
    end
  end
end
