require 'rails_helper'

describe 'UsersAPI', type: :request do
  describe 'GET /users/:id' do
    subject { get "/users/#{user.id}" }

    context 'when user exists' do
      let(:user) { create(:user, :with_avatar) }

      it 'returns the user' do

      end
    end

    context 'when user does not exist' do
      it 'does not return the user' do

      end
    end
  end
end
