require 'spec_helper'

describe 'Editing todo lists' do
  let(:user) { create(:user) }
  let!(:todo_list) { create(:todo_list) }
  let!(:todo_item) { todo_list.todo_items.create(content: "Milk")}

  before do
    sign_in(todo_list.user, password: "password1234")
  end

  it 'should succes when marking a single item complete' do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list todo_list
    within dom_id_for(todo_item) do
      click_link "Mark Complete"
    end
    todo_item.reload
    expect(todo_item.completed_at).to_not be_nil
  end

  context "when items are marked as completed" do
    let!(:completed_todo_item) { todo_list.todo_items.create(content: "Eggs", completed_at: 5.minutes.ago) }
    it 'should show completed items as completed with the time' do
      visit_todo_list todo_list
      within dom_id_for(completed_todo_item) do
        expect(page).to have_content(completed_todo_item.completed_at)
      end
    end
    it 'does not show Mark Complete link' do
      visit_todo_list todo_list
      within dom_id_for(completed_todo_item) do
        expect(page).not_to have_content("Mark Complete")
      end
    end

  end
end
