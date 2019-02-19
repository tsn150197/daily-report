class Comment < ApplicationRecord
  belongs_to :report
  belongs_to :user
  acts_as_tree order: "created_at ASC"
end
