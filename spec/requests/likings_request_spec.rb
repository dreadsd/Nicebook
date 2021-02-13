require 'rails_helper'

RSpec.describe "Likings", type: :request do
  before do
    user = User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678")
    user.posts.create(body: "dummy...")
    sign_in user
  end

  let(:valid_attributes) {
    {user_id: User.first.id, post_id: Post.first.id}
  }

  let(:invalid_attributes) {
    {user_id: User.first.id, post_id: nil}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Liking" do
        expect {
          post likings_url, params: { liking: valid_attributes }
        }.to change(Liking, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Liking" do
        expect {
          post likings_url, params: { liking: invalid_attributes }
        }.to change(Liking, :count).by(0)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested liking" do
      liking = Liking.create! valid_attributes
      expect {
        delete liking_url(liking)
      }.to change(Liking, :count).by(-1)
    end
  end
end
