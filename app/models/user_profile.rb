class UserProfile < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {maximum: Settings.name_maximum}
end
