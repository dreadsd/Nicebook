require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    user = User.create(name: "Dummy test", email: "dummy@test.com", password: "12345678")
    sign_in user
    assign(:posts, [
      Post.create!(body: "Dummy", author: user),
      Post.create!(body: "Test", author: user)
    ])
  end

  it "renders a list of posts" do
    render

    expect(rendered).to have_selector(".author-name", text: "Dummy test")
    expect(rendered).to have_selector(".pub-at", text: "less than a minute")
    expect(rendered).to match(/Dummy/)
    expect(rendered).to match(/Test/)
  end
end
