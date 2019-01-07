# frozen_string_literal: true

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
  validates :email, :first_name, :last_name, presence: true
  validates(
    :phone_number,
    numericality: { only_integer: true }, allow_nil: true, on: :update
  )
  validates_length_of :phone_number, is: 9, allow_nil: true, on: :update

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def name
    [first_name, last_name].join(' ')
  end
end
