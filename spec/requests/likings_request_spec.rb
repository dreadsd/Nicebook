require 'rails_helper'

RSpec.describe "Likings", type: :request do
  let(:user)  { User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678") }
  let(:user1) { User.create(name: "Wrong-----", email: "wrong@test.com", password: "12345678") }
  let(:post)  { user.posts.create(body: "Dummy test") }

  describe "DELETE /destroy" do
    it "destroys the requested liking" do
      liking = Liking.create!(user: user, post: post)
      expect {
        delete liking_url(liking)
      }.to change(Liking, :count).by(-1)
    end
  end

  describe "GET /like" do
    context "with right user" do
      it "likes the post" do
        sign_in user
        expect {
          get like_post_url(user, post)
        }.to change(post.likes, :count).by(1)
      end
    end

    context "with wrong user" do
      it "discards the request" do
        sign_in user1
        expect {
          get like_post_url(user, post)
        }.to raise_error(ActionController::RoutingError)
        expect(post.likes.count).to eq(0)
      end
    end
  end
end
