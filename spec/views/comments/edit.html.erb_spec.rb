require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678")
    User.first.posts.create(body: "dummy post")

    @comment = assign(:comment, Comment.create!(
      author: User.first,
      commentable: Post.first,
      body: "dummy comment"
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input[name=?]", "comment[body]"
    end
  end
end
