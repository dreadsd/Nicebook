require "rails_helper"
require "support/validate_record_helper"

RSpec.configure { |c| c.include RecordValidations }

RSpec.describe Friendship, type: :model do
  let(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
  let(:jane) { User.create(name: "Jane Doe", email: "jane@doe.com", password: "12345678") }

  describe "validations" do
    it "is invalid when user is not given" do
      check_validation_of(Friendship.new(friend: john), :invalid?)
    end

    it "is invalid when friend is not given" do
      check_validation_of(Friendship.new(user: jane), :invalid?)
    end

    it "is invalid when both are not given" do
      check_validation_of(Friendship.new, :invalid?)
    end

    it "is valid when all attributes are given" do
      check_validation_of(Friendship.new(user: john, friend: jane), :valid?)
    end
  end

  describe "friend request" do
    before do
      expect(Friendship.all).to be_empty
      Friendship.create(user: john, friend: jane)
    end

    it "gets the sender" do
      expect(Friendship.first.user).to be_an_instance_of(User)
    end

    it "gets the receiver" do
      expect(Friendship.first.friend).to be_an_instance_of(User)
    end

    describe "accept request" do
      before do
        expect { Friendship.first.accept_request }.not_to raise_error
      end

      it "creates a new Friendship instance" do
        expect(Friendship.all.size).to eq(2)
      end

      describe "new request" do
        it "sets old user to new friend" do
          expect(Friendship.first.user).to eq(Friendship.last.friend)
        end

        it "sets old friend to new user" do
          expect(Friendship.first.friend).to eq(Friendship.last.user)
        end
      end
    end
  end
end
