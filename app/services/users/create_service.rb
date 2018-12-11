module Users
  class CreateService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      user = User.new(
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        first_name: params[:first_name],
        last_name: params[:last_name],
        avatar: File.open('app/assets/images/fallback/default.jpg')
      )
      user.save ? success(data: user) : failure(data: user, message: user.errors.full_messages)
    end

    private

    attr_reader :params
  end
end
