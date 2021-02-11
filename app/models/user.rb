class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :added_friendships,
    class_name: "Friendship", foreign_key: :user_id,
    dependent: :destroy
  has_many :added_friends, through: :added_friendships, source: :friend

  has_many :accepted_friendships,
    class_name: "Friendship", foreign_key: :friend_id,
    dependent: :destroy
  has_many :accepted_friends, through: :accepted_friendships, source: :user
end
