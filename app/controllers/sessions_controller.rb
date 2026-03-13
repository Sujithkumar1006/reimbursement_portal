class SessionsController < ApplicationController
    before_action :redirect_if_logged_in, only: %i[ new ]

  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      user.admin? ? (redirect_to employees_path) :  (redirect_to bills_path)
    else
      @error_message = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end
end
