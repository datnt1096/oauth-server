class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i(user admin)

  validates :name, presence: true

  mount_uploader :image, ImageUploader
end
