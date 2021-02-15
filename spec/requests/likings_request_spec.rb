require 'rails_helper'

RSpec.describe "Likings", type: :request do
  let(:user)  { User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678") }
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
    before do
      sign_in user
    end

    context "with existing post" do
      it "likes the post" do
        expect {
          get like_post_url(post)
        }.to change(post.likes, :count).by(1)
      end
    end

    context "with non-existing post" do
      it "discards the request" do
        expect {
          get like_post_url(id: 0)
        }.to raise_error(ActionController::RoutingError)
        expect(post.likes.count).to eq(0)
      end
    end
  end
end
