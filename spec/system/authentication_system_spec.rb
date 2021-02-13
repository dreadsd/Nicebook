require 'rails_helper'

RSpec.describe "Authentications", type: :system do
  before do
    driven_by(:rack_test)
    User.create(email: "system@test.com", password: "12345678")
  end

  it "logs in before anything" do
    visit "/"

    expect(page).to have_text("Log in")
    fill_in "Email", with: "system@test.com"
    fill_in "Password", with: "12345678"
    click_button "Log in"

    expect(page).to have_text("Signed in successfully.")
  end
end
