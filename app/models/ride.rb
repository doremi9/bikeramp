class Ride < ApplicationRecord
  belongs_to :user
  validates_presence_of :start_address, :destination_address, :price, :date, :user

  scope :weekly, -> { where(date: Date.current.beginning_of_week..Date.current.end_of_week) }
  scope :monthly, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month) }

  def as_json(options)
    {
      id: self.id,
      start_address: self.start_address,
      destination_address: self.destination_address,
      distance: self.distance,
      price: self.price.to_f,
      date: self.date,
      user_id: self.user.id
    }
  end
end
