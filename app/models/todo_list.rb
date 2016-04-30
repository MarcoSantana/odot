class TodoList < ActiveRecord::Base

  has_many :todo_items, dependent: :destroy
  has_paper_trail

  validates :title, presence:true, length: { minimum: 3 }

  validates :description, presence:true, length: { minimum: 3 }

  def has_complete_items?
    todo_items.complete.size > 0
  end

  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end

end
