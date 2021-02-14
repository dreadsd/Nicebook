require "rails_helper"
require "support/validate_record_helper"

RSpec.configure { |c| c.include RecordValidations }

RSpec.describe Post, type: :model do
  describe "validations" do
    it "is invalid when author is not given" do
      check_validation_of(Post.new, :invalid?)
    end
  end
end
