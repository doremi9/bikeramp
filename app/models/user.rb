class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, AvatarUploader
  
  has_many :rides
  has_many :weekly_rides, -> { weekly }, class_name: 'Ride', inverse_of: :user
  has_many :monthly_rides, -> { monthly }, class_name: 'Ride', inverse_of: :user
  has_many :invoices
  validates(
    :email, :password, :password_confirmation, :first_name, :last_name,
    presence: true
  )

  validates :password, length: { minimum: 6 }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def name
    [first_name, last_name].join(' ')
  end
end
