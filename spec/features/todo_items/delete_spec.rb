require "rails_helper"

describe "Deleting todo items" do
  let!(:todo_list) { TodoList.create( title:"Grocery list", description:"Groceries" ) }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk")}


  it 'should success' do
    visit_todo_list(todo_list)
    expect(page).to have_content("Delete")
    within "#todo_item_#{todo_item.id}" do
      click_link "Delete"
    end
    expect(page).to have_content("Todo list item was deleted")
    expect(TodoItem.count).to eq(0)
  end
end
