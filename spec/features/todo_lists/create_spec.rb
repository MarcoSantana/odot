#require 'spec_helper'
require 'rails_helper'

describe "when creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||="My todo list"
    options[:description] ||="This is my todo list"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content "New Todo List"

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "should redirect to the todo list index page on success" do
    create_todo_list

    expect(page).to have_content("Todo list was successfully created.")

  end

  it "should display an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Things to be done")
  end

  it "should display an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("My todo list")
  end

  it "should display an error when the title has less than 3 chars " do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end

  it "should display an error when the description has less than 3 chars" do
    expect(TodoList.count).to eq(0)
    create_todo_list description: "Hi"

    expect(page).to have_content("Description is too short (minimum is 3 characters)")
    expect(TodoList.count).to eq(0)
  end


end
