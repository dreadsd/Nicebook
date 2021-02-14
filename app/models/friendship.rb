class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates_presence_of :user, :friend

  def accept_request
    self.update(status: true)
    Friendship.create(
      user_id: self.friend_id,
      friend_id: self.user_id,
      status: true
    )
  end
end
