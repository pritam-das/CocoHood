class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def ensure_logged_in
    unless current_user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    end
  end

  helper_method :current_user, :ensure_logged_in
end
