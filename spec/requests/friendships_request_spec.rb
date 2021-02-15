require 'rails_helper'

RSpec.configure do |c|
  c.before(:example, :with_friendship) do
    expect(jane.friend_requests).to be_empty
    john.send_request_to(jane)
  end
end

RSpec.describe "Friendships", type: :request do
  let(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
  let(:jane) { User.create(name: "Jane Doe", email: "jane@doe.com", password: "12345678") }
  let(:friendship) { jane.friend_requests.first }

  describe "DELETE /destroy", :with_friendship do
    it "destroys the requested friendship" do
      expect {
        delete friendship_url(friendship)
      }.to change(jane.friend_requests, :count).by(-1)
    end
  end

  describe "GET /send_request" do
    before do
      sign_in john
    end

    context "with existing user" do
      it "sends a friend request" do
        expect {
          get send_request_url(jane)
        }.to change(jane.friend_requests, :count).by(1)
      end
    end

    context "with non-existing user" do
      it "discards the request" do
        expect {
          get send_request_url(id: 1234)
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET /accept", :with_friendship do
    context "with existing friend request" do
      it "accepts the requested friendship" do
        sign_in jane
        get accept_request_url(friendship)
        friendship.reload
        expect(friendship.status).to be true
      end
    end

    context "with non-existing friend request" do
      it "discards the request" do
        sign_in john
        expect {
          get accept_request_url(friendship)
        }.to raise_error(ActionController::RoutingError)
        friendship.reload
        expect(friendship.status).to be false
      end
    end
  end

  describe "GET /unfriend", :with_friendship do
    before do
      jane.friend_requests.first.accept_request
    end

    context "with existing friend" do
      it "unfriends from one side" do
        sign_in jane
        get unfriend_url(john)
        expect(jane.friends).to be_empty
      end

      it "unfriends from the other side" do
        sign_in john
        get unfriend_url(jane)
        expect(john.friends).to be_empty
      end
    end

    context "with non-existing friend" do
      let(:wrong_user) { User.create(name: "Wrong User", email: "wrong@user.com", password: "12345678") }

      it "discards the request" do
        sign_in wrong_user
        expect {
          get unfriend_url(john)
        }.to raise_error(ActionController::RoutingError)
        expect(jane.friends).to include(john)
      end
    end
  end
end
