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

  it "hehe" do
    save_and_open_page
  end
end
