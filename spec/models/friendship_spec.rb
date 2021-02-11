require "rails_helper"

RSpec.describe Friendship, type: :model do
  let(:john) { User.create(email: "john@doe.com", password: "12345678") }
  let(:jane) { User.create(email: "jane@doe.com", password: "12345678") }

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
