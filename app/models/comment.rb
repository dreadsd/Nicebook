class Comment < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  before_save :set_nested,
    if: Proc.new { commentable.instance_of?(Comment) }
  before_save :raise_invalid,
    if: Proc.new { commentable.nested }

  private

  def set_nested
    self.nested = true
  end

  def raise_invalid
    raise ActiveRecord::RecordInvalid
  end
end
