class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :name, presence: true

  before_create :set_default_status

  enum status: {
    created: 'Created',
    in_progress: 'In Progress',
    completed: 'Completed',
    stalled: 'Stalled'
  }

  def set_default_status
    self.status ||= 'Created'
  end

  def owner?(user)
    self.user == user
  end
end
