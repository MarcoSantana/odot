require "rails_helper"

describe "Viewing the items" do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  before do
    sign_in( todo_list.user, password: "password1234")
  end

  it 'should display the title of the list' do
    visit_todo_list(todo_list)
      within(:css, "h1#todo_list_#{todo_list.id}")do
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

    expect(page.all("table.todo_items tr td").size).to eq(6)

    within "table.todo_items" do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Klim")
    end

  end


end
