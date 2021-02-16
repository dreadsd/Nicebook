 require 'rails_helper'

RSpec.describe "/comments", type: :request do
  before do
    User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678")
    User.first.posts.create(body: "hello world")
    sign_in User.first
  end

  let(:valid_attributes) {
    {author_id: User.first.id, commentable_id: Post.first.id, commentable_type: Post, body: "dummy test"}
  }

  let(:invalid_attributes) {
    {author: User.first, body: "dummy test"}
  }

  describe "GET /show" do
    it "renders a successful response" do
      comment = Comment.create! valid_attributes
      get comment_url(comment)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      comment = Comment.create! valid_attributes
      get edit_comment_url(comment)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the created comment" do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        skip
        expect {
          post comments_url, params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        skip
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {body: "[EDITED] dummy test"}
      }

      it "updates the requested comment" do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(comment.body).to eq("[EDITED] dummy test")
      end

      it "redirects to the comment" do
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: new_attributes }
        comment.reload
        expect(response).to redirect_to(root_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        skip
        comment = Comment.create! valid_attributes
        patch comment_url(comment), params: { comment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment = Comment.create! valid_attributes
      expect {
        delete comment_url(comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      comment = Comment.create! valid_attributes
      delete comment_url(comment)
      expect(response).to redirect_to(root_url)
    end
  end
end
