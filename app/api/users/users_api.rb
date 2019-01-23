module Users
  class UsersAPI < Base
    helpers do
      params :user_params do
        optional :first_name, type: String
        optional :last_name, type: String
        optional :avatar, type: File
        optional :hourly_rate, type: String
        optional :phone_number, type: Integer
        optional :facebook_url, type: String
        optional :twitter_url, type: String
        optional :linked_in_url, type: String
      end
    end
    
    desc 'Update the user'
    params do
      use :user_params
    end

    patch '/:id' do
      user = User.find(params[:id])
      user.update(params)
      raise ValidationError, user.errors.full_messages unless user.valid?

      return { status: 204 }
    end

    desc 'Fetch current user'
    get '/:id' do
      User.find(params[:id])
    end
  end
end
