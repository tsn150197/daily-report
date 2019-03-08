class Report < ApplicationRecord
  enum status: {rejected: 0, approved: 1}
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :date, presence: true
  scope :order_date, ->{order date: :desc}
  scope :where_title, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :where_from_date, ->(from_date){where "date >= ?", from_date}
  scope :where_to_date, ->(to_date){where "date <= ?", to_date}
end
