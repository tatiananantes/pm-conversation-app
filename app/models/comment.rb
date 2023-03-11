class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  validates :body, presence: :true

  def owner?(user)
    self.user == user
  end
end
