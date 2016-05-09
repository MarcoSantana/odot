FactoryGirl.define do
  factory :user do
    name                  "Marco Antonio"
    last_name             "Santana"
    sequence(:email)     { |n| "user#{n}@odot.com" }
    password              "password1234"
    password_confirmation "password1234"
  end

  factory :todo_list do
    title "Todo List Title"
    description "Todo List description"
    user
  end
end
