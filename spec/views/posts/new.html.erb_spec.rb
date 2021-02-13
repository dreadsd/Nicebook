require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
   user = User.create(email: "dummy@test.com", password: "12345678")
   sign_in user
   assign(:post, Post.new(body: "Dummy test", author: user))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do
    end
  end
end
