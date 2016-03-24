#require 'spec_helper'
require 'rails_helper'

describe "when creating todo lists" do
  it "should redirect to the todo list index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content "New Todo List"

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "Things to be done"
    click_button "Create Todo list"

    expect(page).to have_content("Todo list was successfully created.")

  end

  it "should display an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content "New Todo List"

    fill_in "Title", with: ""
    fill_in "Description", with: "Things to be done"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Things to be done")
  end

  it "should display an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page). to have_content "New Todo List"

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: ""
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("My todo list")
  end

  it "should display an error when the title has less than 3 chars " do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Hi" #Less than 3 chars length string
    fill_in "Description", with: "Things to be done"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)
  end

  it "should display an error when the description has less than 3 chars" do
    expect(TodoList.count).to eq(0)
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "My todo list"
    fill_in "Description", with: "hi"
    click_button "Create Todo list"

    expect(page).to have_content("Description is too short (minimum is 3 characters)")
    expect(TodoList.count).to eq(0)
  end


end
