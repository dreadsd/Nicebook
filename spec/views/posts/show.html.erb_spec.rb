require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    user = User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678")
    sign_in user
    @post = assign(:post, Post.create!(body: "Dummy test", author: user))
  end

  it "renders attributes in <p>" do
    render
  end
end
