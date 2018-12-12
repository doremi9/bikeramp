module Users
  class UsersAPI < Base
    get '/:id' do
      User.find(params[:id])
    end
  end
end
