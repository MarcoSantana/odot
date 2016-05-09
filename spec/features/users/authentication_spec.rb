require 'rails_helper'


describe "Loggin in" do
  it "logs the user in and goes to the todo lists" do
    User.create(name: "Marco", last_name: "Santana", email: "marco.santana@gmail.com", password: "treehouse1", password_confirmation: "treehouse1")
    visit new_user_session_path
    fill_in("Email Address", with: "marco.santana@gmail.com")
    fill_in("Password", with: "treehouse1")
    click_button "Log In"
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")

  end
  it "displays teh email address in the event of a failed login" do
    visit new_user_session_path
    fill_in("Email Address", with: "marco.santana@gmail.com")
    fill_in("Password", with: "incorrect")
    click_button "Log In"
    expect(page).to have_content("There was a problem logging in. Please check your email and password")
    expect(page).to have_field("Email Address", with: "marco.santana@gmail.com")
  end

end
