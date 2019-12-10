class Recharge < ApplicationRecord
  belongs_to :user

  enum status: %i(pending done cancel)
  validates :amount, presence: true, numericality: {greater_than: 0}
end
