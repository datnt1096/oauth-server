class Authorization < ApplicationRecord
  belongs_to :user
  belongs_to :oauth_app
end
