require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  let(:john) { User.create(name: "John Doe", email: "john@doe.com", password: "12345678") }
  let(:jane) { User.create(name: "Jane Doe", email: "jane@doe.com", password: "12345678") }
  let(:friendship) { jane.friend_requests.first }

  before do
    expect(jane.friend_requests).to be_empty
    john.send_request_to(jane)
  end

  describe "DELETE /destroy" do
    it "destroys the requested friendship" do
      expect {
        delete friendship_url(friendship)
      }.to change(jane.friend_requests, :count).by(-1)
    end
  end

  describe "GET /accept" do
    context "with right user" do
      it "accepts the requested friendship" do
        sign_in jane
        get accept_request_url(friendship)
        friendship.reload
        expect(friendship.status).to be true
      end
    end

    context "with wrong user" do
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

  describe "GET /unfriend" do
    before do
      jane.friend_requests.first.accept_request
    end

    context "with right user" do
      it "unfriends from one side" do
        sign_in jane
        get unfriend_url(jane, john)
        expect(jane.friends).to be_empty
      end

      it "unfriends from the other side" do
        sign_in john
        get unfriend_url(john, jane)
        expect(john.friends).to be_empty
      end
    end

    context "with wrong user" do
      let(:wrong_user) { User.create(name: "Wrong User", email: "wrong@user.com", password: "12345678") }

      it "discards the request" do
        sign_in wrong_user
        expect {
          get unfriend_url(jane, john)
        }.to raise_error(ActionController::RoutingError)
        expect(jane.friends).to include(john)
      end
    end
  end
end
