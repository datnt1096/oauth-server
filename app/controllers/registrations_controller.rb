class RegistrationsController < Devise::RegistrationsController
  layout false

  skip_before_action :authenticate_user!
end
