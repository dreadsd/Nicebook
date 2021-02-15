require 'rails_helper'

RSpec.describe "Authentication System", type: :system do
  before do
    driven_by(:rack_test)
    User.create(name: "System Test", email: "system@test.com", password: "12345678")
  end

  it "logs in" do
    visit "/"

    expect(page).to have_text("Log in")
    fill_in "Email", with: "system@test.com"
    fill_in "Password", with: "12345678"
    click_button "Log in"

    expect(page).to have_text("Signed in successfully.")
  end

  it "logs out" do
    sign_in User.first
    visit "/"

    click_link("sign-out")

    expect(page).to have_text("You need to sign in or sign up before continuing.")
    expect(page).to have_text("Log in")
  end
end
