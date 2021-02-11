class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def accept_request
    self.update(status: true)
  end
end
