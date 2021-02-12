require 'rails_helper'

RSpec.describe "PostSystems", type: :system do
  before do
    driven_by(:rack_test)

    email = "post@system.com"
    password = "12345678"

    User.create(email: email, password: password)

    visit "/"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
    expect(page).to have_text("Posts")
  end

  it "hehe" do
    save_and_open_page
  end
end
