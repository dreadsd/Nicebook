require "rails_helper"

RSpec.describe Friendship, type: :model do
  let(:first_user)  { User.create(email: "john@doe.com", password: "johndoe01", password_confirmation: "johndoe01") }
  let(:second_user) { User.create(email: "jane@doe.com", password: "janedoe01", password_confirmation: "janedoe01") }

  before do
    first_user.added_friends << second_user
  end

  context "friend access" do
    it "ensures the same friendship" do
      expect(first_user.added_friendships.last).to eq(second_user.accepted_friendships.last)
    end

    it "sets the added friend to the first user" do
      expect(first_user.added_friends.last).to eq(second_user)
    end

    it "sets the accepted friend to the second user" do
      expect(second_user.accepted_friends.last).to eq(first_user)
    end
  end

  context "removing friendship" do
    it "deletes the friendship itself" do
      first_user.added_friendships.last.destroy

      first_user.added_friends.reload
      second_user.accepted_friends.reload

      expect(first_user.added_friends.empty?).to be true
      expect(second_user.accepted_friends.empty?).to be true
    end

    it "deletes sender from accepted friends" do
      first_user.destroy

      second_user.accepted_friendships.reload
      second_user.accepted_friends.reload

      expect(second_user.accepted_friendships.empty?).to be true
      expect(second_user.accepted_friends.empty?).to be true
    end

    it "deletes receiver from added friends" do
      second_user.destroy

      first_user.added_friendships.reload
      first_user.added_friends.reload

      expect(first_user.added_friendships.empty?).to be true
      expect(first_user.added_friends.empty?).to be true
    end
  end
end
