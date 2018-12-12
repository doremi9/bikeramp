# frozen_string_literarl: true

module UserServices
  class Update < ApplicationService
    def initialize(user, params)
      @user   = user
      @params = params
    end

    def call
      user.update!(params)
      success
    end

    private

    attr_reader :user, :params
  end
end