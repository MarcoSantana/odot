require "rails_helper"

describe "Adding the items" do
  let!(:todo_list) { TodoList.create( title:"Grocery list", description:"Groceries" ) }


  it 'should success with valid content' do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Milk"
    click_button "Save"
    expect(page).to have_content("Added todo list item")
    within("table.todo_items") do
      expect(page).to have_content("Milk")
    end

  end

  it 'should display an error with no content' do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: ""
    click_button "Save"
    within("div.flash") do
      expect(page).to have_content("There was a problem adding that todo list item")
    end
    expect(page).to have_content("can't be blank")
  end

  it 'should display error with content < 3 chars' do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "hi"
    click_button("Save")
    expect(page).to have_content("Content is too short (minimum is 3 characters)")
    # within("div.flash") do
    #   expect(page).to have_content("Content is too short (minimum is 3 characters)")
    # end
  end

end
