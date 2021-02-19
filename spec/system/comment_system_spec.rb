require 'rails_helper'

RSpec.configure do |c|
  c.before(:example, :with_comment) do
    post.comments.create(author: user, body: "hello world")
    visit "/"
  end
end

RSpec.describe "Comment System", type: :system do
  let!(:user) { User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678") }
  let!(:post) { user.posts.create(body: "dummy test") }

  before do
    driven_by(:rack_test)

    sign_in user
    visit "/"
  end

  describe "comments#create" do
    it "can create a comment" do
      expect {
        fill_in("comment-#{post.id}", with: "hello world")
        click_button("Send")
      }.to change(post.comments, :count).by(1)
    end

    it "has the comment body", :with_comment do
      expect(find(".comment-body")).to have_content("hello world")
    end
  end

  describe "comments#show" do
    it "can show a comment", :with_comment do
      expect { find(".comments-show").click }.not_to raise_error
      expect(find(".comment-body")).to have_content("hello world")
    end
  end

  describe "comments#edit" do
    it "can edit a commend", :with_comment do
      expect { find(".comments-edit").click }.not_to raise_error

      expect {
        fill_in("comment-#{post.id}", with: "goodbye world")
        click_button("Send")
      }.not_to raise_error

      expect(Comment.first.body).to eq("goodbye world")
    end
  end
end
