class Group < ApplicationRecord
  belongs_to :user
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses

  validates :name, presence: true, uniqueness: true,
                   length: { minimum: 2, too_short: '%<count> characters is the minimum allowed' }
  validates :icon, presence: true

  def total
    expenses.sum { |expense| expense.amount }
  end

  def self.icon_list
    ['🍴', '🛍️', '🎁', '🏠', '👨‍👩‍👦', '👨‍🎓', '💅', '🐶', '✈️', '🚍', '🚘', '🧍🏻', '💻', '💰', '💹', '🏥', '🏖️', '🚰', '⚡']
  end
end