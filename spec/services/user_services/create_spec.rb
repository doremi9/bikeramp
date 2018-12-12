require 'rails_helper'

describe UserServices::Create, type: :service do
  include ActiveJob::TestHelper

  let(:attributes) do
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  subject { described_class.new(attributes) }

  context 'valid attributes' do
    let(:email) { 'some@email.com' }
    let(:password) { 'password' }
    let(:first_name) { 'John' }
    let(:last_name) { 'Doe' }
    let(:password_confirmation) { 'password' }

    it 'creates a new user' do
      result = subject.call
      expect(result).to be_success
      expect(result.data).to be_valid
    end

    it 'enqueues confirmation email job' do
      user = subject.call.data
      expect do
        Devise::Mailer.confirmation_instructions(user).deliver_later
      end.to have_enqueued_job.on_queue('mailers')
    end
  end

  context 'invalid attributes' do
    let(:email) {}
    let(:first_name) {}
    let(:last_name) {}
    let(:password) {}
    let(:password_confirmation) {}

    it 'does not create a new user' do
      result = subject.call
      expect(result).not_to be_success
      expect(result.data).to be_invalid
      expect(result.message).to eq(
        ["Email can't be blank",
         "Password can't be blank",
         'Password is too short (minimum is 6 characters)',
         "Password confirmation can't be blank",
         "First name can't be blank", "Last name can't be blank"]
      )
    end
  end
end
