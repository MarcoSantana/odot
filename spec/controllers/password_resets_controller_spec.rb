require 'spec_helper'

RSpec.describe PasswordResetsController, type: :controller do


  describe "GET new" do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context "with valid user and email " do
      let(:user) { create(:user) }

      it 'finds the user' do
        expect(user).to receive(:find_by).with(email: user.email)
        post :create, email: user.email

      end

      it 'generates a new password reset token' do

      end

    end
  end


end
