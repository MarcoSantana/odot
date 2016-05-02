require 'rails_helper'


describe "Signing up" do
  it 'allows an user to sign up for the site and creates the object in the database' do
    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"
    password = Faker::Internet.password
    fill_in "Name", with: Faker::Name.first_name
    fill_in("Last Name", with: Faker::Name.last_name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Password", with: password)
    fill_in("Password confirmation", with: password)
    click_button "Sign Up"

    expect(User.count).to eq(1)

  end
end
