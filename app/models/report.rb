class Report < ApplicationRecord
  enum status: {rejected: 0, approved: 1}
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, uniqueness: {scope: :user_id},
    length: {maximum: Settings.string_maximum}
  validates :date, presence: true
  validate :min_date, :max_date
  scope :order_date, ->{order date: :desc}
  scope :where_title, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :where_from_date, ->(from_date){where "date >= ?", from_date}
  scope :where_to_date, ->(to_date){where "date <= ?", to_date}

  private

  def min_date
    return unless date <= Settings.min_date
    errors.add :date, I18n.t("activerecord.min_date",
      date: Settings.min_date.strftime("%d/%m/%Y"))
  end

  def max_date
    return unless date >= Settings.max_date
    errors.add :date, I18n.t("activerecord.max_date",
      date: Settings.max_date.strftime("%d/%m/%Y"))
  end
end
