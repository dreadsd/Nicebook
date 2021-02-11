class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def accept_request
    self.update(status: true)
    Friendship.create(
      user_id: self.friend_id,
      friend_id: self.user_id,
      status: true
    )
  end
end
