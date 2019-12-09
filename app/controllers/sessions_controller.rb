class SessionsController < Devise::SessionsController
  layout false

  skip_before_action :authenticate_user!
end
