class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(login_helper[:email_in]).try(:authenticate,login_helper[:pass_in])
    if @user
        session[:user_id] = @user.id
        redirect_to events_path
    else
        flash[:errors] = ["User and Password combination not found"]
        redirect_to '/'
    end
  end

  def destroy
      session[:user_id] = nil
      redirect_to '/'
  end

  private
  def login_helper
      params.require(:login).permit(:email_in,:pass_in) if params[:login].present?
  end
end
