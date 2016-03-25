require "rails_helper"

describe "Viewing the items" do
  let!(:todo_list) { TodoList.create( title:"Grocery list", description:"Groceries" ) }

  it 'should display not items when this list is empty' do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "List Items"
    end
    expect(page).to have_content("TodoItems#index")

  end

end
