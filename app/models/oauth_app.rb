class OauthApp < ApplicationRecord
  VALID_URL_REGEX = /(?:^|\s)((https?:\/\/)?(?:localhost|[\w-]+(?:\.[\w-]+)+)(:\d+)?(\/\S*)?)/

  belongs_to :user
  has_many :authorizations, dependent: :destroy

  validates :name, :home_page, :secret_key, :callback_url, presence: true
  validates :home_page, :callback_url, format: {with: VALID_URL_REGEX, message: "sai định dạng"}

  scope :order_asc, ->{order :created_at}
end
