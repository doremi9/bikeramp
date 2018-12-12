module Users
  class UsersAPI < Base
    desc 'Update the user'
    params do
      optional :first_name, type: String
      optional :last_name, type: String
      optional :avatar, type: File
      optional :password, type: String
      optional :password_confirmation, type: String
    end
    patch do
      UserServices::Update.new(current_user, params).call
      body false
    end
  end
end
