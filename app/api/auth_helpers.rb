module AuthHelpers
  def authenticate_user!
    begin
      payload = JsonWebToken.decode(token)
      @current_user = User.find_by(id: payload['user_id'])
    rescue
      error!(I18n.t('authorization.unauthenticated'), 401)
    end
  end

  def current_user
    @current_user ||= authenticate_user!
  end

  def token
    request.headers['Authorization'].split(' ').last
  end
end
