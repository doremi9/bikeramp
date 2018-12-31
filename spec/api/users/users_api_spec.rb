require 'rails_helper'

describe 'UsersAPI', type: :request do
  describe 'PATCH /api/users/:id' do
    let(:user) { create(:user) }
    let(:params) do
        {
          first_name: 'John',
          last_name: 'Doe',
          password: 'password',
          password_confirmation: 'password',
          avatar: fixture_file_upload("spec/fixtures/files/jpg.jpg", 'image/jpeg')
        }
    end
    subject { patch "/api/users/#{id}", headers: headers, params: params }

    context 'when user is authenticated' do  
      let(:id) { user.id }
      let(:headers) { auth_headers(user) }   

      include_examples '204'

      it 'updates the user' do
        subject
        updated_user = user.reload
        expect(updated_user.first_name).to eq(params[:first_name])
        expect(updated_user.last_name).to eq(params[:last_name])
        expect(updated_user.avatar.url).not_to be_empty
      end
    end

    context 'when user is not authenticated' do
      let(:id) { user.id }

      include_examples 'Unauthenticated'
    end
  end
end
