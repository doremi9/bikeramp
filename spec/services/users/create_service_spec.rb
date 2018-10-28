require 'rails_helper'

describe Users::CreateService, type: :service do
  include ActiveJob::TestHelper

  let(:attribtues) do
    {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  subject { described_class.new(attribtues) }

  context 'valid attribtues' do
    let(:email) { 'some@email.com' }
    let(:password) { 'password' }
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

  context 'invalid attribtues' do
    let(:email) {}
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
         "Password confirmation can't be blank"]
      )
    end
  end
end