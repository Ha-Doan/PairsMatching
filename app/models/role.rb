class Role < ApplicationRecord
  has_many :user
  validates :role, presence: true


end
