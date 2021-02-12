require 'rails_helper'
require 'support/user_helpers'

RSpec.configure do |c|
  c.include UserHelpers
end

RSpec.describe "Post System", type: :system do
  before do
    driven_by(:rack_test)

    authenticate
  end

  it "can create a new post" do
    fill_in "post_body", with: "hello world"
    click_button "Post"
    expect(page).to have_content "hello world"
    save_and_open_page
  end
end
