class Group < ApplicationRecord
  belongs_to :user
  has_many :group_expenses, dependent: :destroy
  has_many :expenses, through: :group_expenses

  validates :name, presence: true, uniqueness: true,
                   length: { minimum: 2, too_short: '%<count> characters is the minimum allowed' }
  validates :icon, presence: true
end