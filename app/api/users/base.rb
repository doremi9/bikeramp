module Users
  class Base < API::Core
    mount UsersAPI
  end
end
