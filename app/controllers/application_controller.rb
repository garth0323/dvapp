class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def navbar
    if user_signed_in?
      render template: './views/layouts/nav' 
    else 
      render template: './views/layouts/navigation' 
    end 
  end
end
