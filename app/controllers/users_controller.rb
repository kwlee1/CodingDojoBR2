class UsersController < ApplicationController
  def index
  end
  def create
    @user = User.new(reg_helper)
    if @user.save
        session[:user_id] = @user.id
        redirect_to events_path
    else
        flash[:errors] = @user.errors.full_messages
        redirect_to '/'
    end
  end 
  def update
    @user = User.find(current_user.id)
    @user.first_name = edit_helper[:first_name]
    @user.last_name = edit_helper[:last_name]
    @user.city = edit_helper[:city]
    @user.state = edit_helper[:state]
    @user.email = edit_helper[:email]
    if @user.save
        redirect_to events_path
    else
        flash[:errrors] = @user.errors.full_messages
        redirect_to edit_user_path(current_user.id)
    end
  end
  def edit 
  end 

  private
  def reg_helper
      params.require(:user).permit(:first_name,:last_name,:email,:city,:state,:password) if params[:user].present?
  end
  def edit_helper
      params.require(:up).permit(:first_name,:last_name,:email,:city,:state) if params[:up].present?
  end
end
