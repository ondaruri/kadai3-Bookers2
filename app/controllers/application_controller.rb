class ApplicationController < ActionController::Base
  #before_action :authenticate_user!#,except: [:top,:show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    @user = current_user
    user_path(@user)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
