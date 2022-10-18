class User < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :expenses, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 2, too_short: '%<count> characters is the minimum allowed' }
end