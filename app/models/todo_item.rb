class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates_presence_of :content
  validates_length_of :content, minimum: 3, maximum: 256
end
