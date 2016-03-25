require "rails_helper"

describe "Delete todo lists" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocerie list") }

  it 'is successfull when clicking th destroy link' do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
