require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    user = User.create(email: "dummy@test.com", password: "12345678")
    sign_in user
    @post = assign(:post, Post.create!(body: "Dummy test", author: user))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do
    end
  end
end
