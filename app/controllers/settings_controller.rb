class SettingsController < ApplicationController
	before_action :set_user, only: [:account, :password, :profile,:update_info,:update_image]
  def account
  end

  def password
  end

  def notifications
  end

  def profile
  end

  def update_info
   
   @user.update_attributes(user_params)
    if @user.save
    	flash[:notice] = "Your info has been updated."
    	redirect_to root_path(current_user)
        
    end
    	
  end	

  def update_image
   
   @user.update_attributes(user_params)
    if @user.save
    	flash[:notice] = "Your info has been updated."
    	redirect_to root_path(current_user)
        
    end
    	
  end	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user

      @user = current_user
    end

  def user_params
    params.require(:user).permit(:username, :email, :password,:password_confirmation, :bio, :location,:avatar,:time_zone,:birthday,:reset_password_token)
  end
end
