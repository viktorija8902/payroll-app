# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171018195151) do

  create_table "time_report_infos", force: :cascade do |t|
    t.date "report_date"
    t.date "pay_period_start"
    t.date "pay_period_end"
    t.decimal "hours_worked"
    t.integer "employee_id"
    t.string "job_group"
    t.integer "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_reports", force: :cascade do |t|
    t.integer "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
