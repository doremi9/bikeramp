require 'rails_helper'

describe 'AuthAPI', type: :request do
  describe 'POST /api/auth' do
    let(:params) do
      {
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        first_name: first_name,
        last_name: last_name
      }
    end

    subject { post '/api/auth', params: params }

    context 'with valid params' do
      let(:email) { 'qwe@qwe.qwe' }
      let(:password) { 'secret_password' }
      let(:password_confirmation) { 'secret_password' }
      let(:first_name) { 'John' }
      let(:last_name) { 'Doe' }

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(1)
        expect(response.status).to eq(200)
      end
    end

    context 'invalid params' do
      let(:params) { {} }

      it 'does not create a user' do
        subject
        expect(response.status).to eq(406)
        expect(response_body).to eq(
          'error' => 'email is missing, password is missing, password_confirmation is missing, first_name is missing, last_name is missing'
        )
      end
    end
  end

  describe 'POST /api/auth/login' do
    let!(:user) { create(:user, :confirmed) }
  
    let(:params) do
      {
        email: email,
        password: password
      }
    end

    subject { post '/api/auth/login', params: params }

    context 'with valid params' do
      let(:email) { user.email }
      let(:password) { user.password }

      include_examples '201'
    end

    context 'with invalid params' do
      context 'invalid username' do
        let(:email) { 'qwe@qwe.com' }
        let(:password) { 'secret_password' }

        it 'returns 403 status code' do
          subject
          expect(response.status).to eq(403)
          expect(response_body).to eq('error' => I18n.t('authorization.invalid_credentials'))
        end
      end

      context 'invalid password' do
        let(:email) { 'qwe@qwe.qwe' }
        let(:password) { 'invalid_password' }

        it 'does not generate JWT token' do
          subject
          expect(response.status).to eq(403)
          expect(response_body).to eq('error' => I18n.t('authorization.invalid_credentials'))
        end
      end
    end
  end
end