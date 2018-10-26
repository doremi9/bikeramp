class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :rides
  has_many :weekly_rides, -> { weekly }, class_name: 'Ride', inverse_of: :user
  has_many :monthly_rides, -> { monthly }, class_name: 'Ride', inverse_of: :user
  validates_presence_of :email, :password, :password_confirmation
  validates :password, length: { minimum: 6 }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
