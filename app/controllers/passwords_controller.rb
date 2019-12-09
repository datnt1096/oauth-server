class PasswordsController < Devise::PasswordsController
  layout false

  skip_before_action :authenticate_user!
end
