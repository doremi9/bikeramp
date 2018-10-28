class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      send_welcome_email
      respond_with_navigational(resource) { redirect_to front_end_host }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { redirect_to front_end_host }
    end
  end

  private

  def send_welcome_email
    WelcomeEmailMailer.welcome_email(resource).deliver_later
  end

  def front_end_host
    Rails.end.development? ? 'http://localhost:8080/login' : ENV['FRONTEND_HOST_LOGIN']
  end
end
