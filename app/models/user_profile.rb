class UserProfile < ApplicationRecord
  enum gender: {female: 0, male: 1}
  belongs_to :user
  validates :name, presence: true, length: {maximum: Settings.name_maximum},
    uniqueness: true
  validates :address, length: {maximum: Settings.string_maximum},
    allow_nil: true
  validates :phone, length: {maximum: Settings.string_maximum},
    allow_blank: true,
      format: {with: /\A\d+\z/, message: I18n.t("activerecord.number")}
  validate :min_birthday, :max_birthday
  mount_uploader :avatar_url, PictureUploader

  private

  def min_birthday
    return unless birthday <= Settings.min_date
    errors.add :birthday, I18n.t("activerecord.min_date",
      date: Settings.min_date.strftime("%d/%m/%Y"))
  end

  def max_birthday
    return unless birthday >= Settings.max_date
    errors.add :birthday, I18n.t("activerecord.max_date",
      date: Settings.max_date.strftime("%d/%m/%Y"))
  end
end
