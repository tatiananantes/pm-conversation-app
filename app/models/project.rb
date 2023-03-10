class Project < ApplicationRecord
  has_many :comments
  belongs_to :user
  
  before_create :set_default_status
  
  enum status: {
    created: "Created",
    in_progress: "In Progress",
    completed: "Completed",
    stalled: "Stalled"
  }

  private

  def set_default_status
    self.status ||= "Created"
  end

end
