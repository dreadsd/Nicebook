require 'rails_helper'

RSpec.describe "Liking System", type: :system do
  let!(:user) { User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678") }
  let!(:post) { user.posts.create(body: "Dummy test") }

  before do
    driven_by(:rack_test)

    sign_in user
    visit "/"
  end

  it "likes the post" do
    expect {
      click_link("Like")
    }.to change(post.likes, :count).by(1)
  end

  it "unlikes the post" do
    Liking.create(user: user, post: post)
    visit "/"

    expect {
      click_link("Like")
    }.to change(post.likes, :count).by(-1)
  end
end
