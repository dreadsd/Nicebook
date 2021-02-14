require "rails_helper"
require "support/validate_record_helper"

RSpec.configure { |c| c.include RecordValidations }

RSpec.describe Liking, type: :model do
  let(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
  let(:post) { john.posts.create(body: "Hello world") }

  describe "validations" do
    it "is invalid when user is not given" do
      check_validation_of(Liking.new(post: post), :invalid?)
    end

    it "is invalid when post is not given" do
      check_validation_of(Liking.new(user: john), :invalid?)
    end

    it "is invalid when both are not given" do
      check_validation_of(Liking.new, :invalid?)
    end

    it "is valid when all attributes are given" do
      check_validation_of(Liking.new(user: john, post: post), :valid?)
    end
  end
end
