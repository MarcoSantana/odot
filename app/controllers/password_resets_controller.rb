class PasswordResetsController < ApplicationController

  def new
    #code
  end

  def create

    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!
      Notifier.password_reset(user).deliver_now
      flash[:success] = 'Email sent'
      redirect_to login_path
    else
      flash[:notice] = 'Email not found'
      render action: :new
    end

  end

end
