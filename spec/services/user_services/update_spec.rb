require 'rails_helper'

describe UserServices::Update, type: :service do
  let(:user) { create(:user) }
  
  subject { described_class.new(user, attributes) }

  context 'valid attributes' do
    let(:attributes) do
      {
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      }
    end

    it 'updates the user successfully' do
      result = subject.call
      expect(result).to be_success
    end
  end
end