require "rails_helper"

describe "Editing list items" do
  let!(:todo_list) { TodoList.create( title:"Grocery list", description:"Groceries" ) }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk")}

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it 'should success with valid content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link("Edit")
    end
    fill_in "Content", with: "Lots of mik"
    click_button("Save")
    expect(page).to have_content("Saved todo list item.")

    todo_item.reload

    expect(todo_item.content).to eq("Lots of mik")
  end

  it 'should fail with no content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link("Edit")
    end
    fill_in "Content", with: ""
    click_button("Save")

    expect(page).to_not have_content("Updated todo list item")
    expect(page).to have_content("can't be blank")

    expect(todo_item.content).to eq("Milk")
  end

  it 'should fail with not enough content' do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link("Edit")
    end
    fill_in "Content", with: "h"
    click_button("Save")

    expect(page).to_not have_content("Updated todo list item")
    expect(page).to have_content("Content is too short")

    expect(todo_item.content).to eq("Milk")
  end

end
