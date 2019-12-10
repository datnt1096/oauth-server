class SessionsController < Devise::SessionsController
  layout false

  skip_before_action :authenticate_user!

  private

  def respond_to_on_destroy
    redirect_to new_user_session_path
  end
end
