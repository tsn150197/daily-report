class Report < ApplicationRecord
  enum status: {rejected: 0, approved: 1}
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
end
