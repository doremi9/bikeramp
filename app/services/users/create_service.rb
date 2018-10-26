module Users
  class CreateService < ApplicationService
    def initialize(params)
      @email = params[:email]
      @password = params[:password]
      @password_confirmation = params[:password_confirmation]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
    end

    def call
      user = User.new(
        email: @email,
        password: @password,
        password_confirmation: @password_confirmation,
        first_name: @first_name,
        last_name: @last_name
      )
      user.save ? success(data: user) : failure(data: user, message: user.errors.full_messages)
    end
  end
end
