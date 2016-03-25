require 'rails_helper'
require "shoulda-matchers"
RSpec.describe TodoItem, type: :model do
  it {should belong_to(:todo_list)}
end
