require 'json_web_token'

module Auth
  class AuthAPI < Base
    helpers do
      params :user_params do
        requires :email, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
        optional :first_name, type: String
        optional :last_name, type: String
      end
    end

    desc 'Creates new user'
    params do
      use :user_params
    end
    post do
      result = Users::CreateService.new(params).call
      if result.success?
        status :ok
      else
        error!({ message: result.message }, 422)
      end
    end

    desc 'Login user'
    params do
      requires :email, desc: 'Email', type: String
      requires :password, desc: 'User password', type: String
    end
    post '/login' do
      user = User.find_by(email: params[:email])
      error!(I18n.t('authorization.invalid_credentials'), 403) unless user.present?
      error!(I18n.t('authorization.invalid_credentials'), 403) unless user.valid_password?(params[:password])
      token = JsonWebToken.issue_token(user_id: user.id)
      { api_token: token, user: user }
    end
  end
end