require 'rails_helper'

describe "Listing todo lists" do
  it 'should require login' do
    visit "/todo_lists"
    expect(page).to have_content("You must be logged in to access this page")
  end

end
