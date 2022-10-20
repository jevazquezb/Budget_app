class Expense < ApplicationRecord
  belongs_to :user
  has_many :group_expenses, dependent: :destroy
  has_many :groups, through: :group_expenses

  validates :name, presence: true,
                   length: { minimum: 2, too_short: '%<count> characters is the minimum allowed' }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
