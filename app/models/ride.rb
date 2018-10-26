class Ride < ApplicationRecord
  belongs_to :user
  validates_presence_of :start_address, :destination_address, :price, :date, :user

  scope :weekly, -> { where(date: Date.current.beginning_of_week..Date.current.end_of_week) }
  scope :monthly, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month) }
end
