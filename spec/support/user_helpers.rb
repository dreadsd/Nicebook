module UserHelpers
  def authenticate
    email = "dummy@test.com"
    password = "12345678"

    User.create(email: email, password: password)

    visit "/"
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Log in"
  end
end
