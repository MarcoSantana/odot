require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:valid_attributes) {
    {
      "name" => "My string",
      "last_name" => "Another string",
      "email" =>  "email@email.com",
      "password"  =>  "password1234",
      "password_confirmation" =>  "password1234"
    }
  }
  before(:each) do
    @user = assign(:user, User.create!(valid_attributes))
  end

  it "renders attributes in <p>" do
    render
  end
end
