class TimeReport < ApplicationRecord
  validates :report_id, uniqueness: true, presence: true
end
