class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, -> { where(status: true) }, foreign_key: :user_id
  has_many :friend_requests, -> { where(status: false) }, class_name: "Friendship", foreign_key: :friend_id
  has_many :friends, through: :friendships

  has_many :posts, foreign_key: :author_id

  has_many :likings
  has_many :liked_posts, through: :likings, source: :post

  validates :name, presence: true, length: { minimum: 4 }

  def send_request_to(user)
    request = Friendship.create(user: self, friend: user)
    user.friend_requests << request
  end
end
