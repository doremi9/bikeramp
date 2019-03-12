# frozen_string_literal: true

module UserServices
  class Create < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      user = User.new(user_params)
      user.save ? success(data: user) : failure(data: user, message: user.errors.full_messages)
    end

    private

    def user_params
      {
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation],
        first_name: params[:first_name],
        last_name: params[:last_name],
        username: username
      }
    end

    def username
      [params[:first_name].first, params[:last_name]].map(&:downcase).join
    end

    attr_reader :params
  end
end
