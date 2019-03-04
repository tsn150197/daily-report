class UserProfile < ApplicationRecord
  enum gender: {female: 0, male: 1}
  belongs_to :user
  validates :name, presence: true, length: {maximum: Settings.name_maximum}
  mount_uploader :avatar_url, PictureUploader
end
