require 'rails_helper'

RSpec.describe "Post System", type: :system do
  before do
    driven_by(:rack_test)

    user = User.create(name: "Dummy Test", email: "dummy@test.com", password: "12345678")
    sign_in user
    visit "/"
  end

  it "can create a new post" do
    fill_in "post_body", with: "hello world"
    click_button "Post"
    expect(page).to have_content "hello world"
    save_and_open_page
  end
end
