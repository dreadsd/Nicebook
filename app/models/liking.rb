class Liking < ApplicationRecord
  belongs_to :user
  belongs_to :post

  vaidates :user_id, uniqueness: { scope: :post }
end
