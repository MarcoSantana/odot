require "rails_helper"

describe "Viewing the items" do
  let!(:todo_list) { TodoList.create( title:"Grocery list", description:"Groceries" ) }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end
  it 'should display the title of the list' do
    visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end

  end

  it 'should display not items when this list is empty' do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(0)

  end

  it 'should display item content when a todo list has items' do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Klim")

    visit_todo_list(todo_list)

    expect(page.all("ul.todo_items li").size).to eq(2)

    within "ul.todo_items" do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Klim")
    end

  end


end
