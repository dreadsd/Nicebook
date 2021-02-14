class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :likings
  has_many :likes, through: :likings, source: :user

  validates_presence_of :author
end
