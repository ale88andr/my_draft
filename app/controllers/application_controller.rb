class ApplicationController < ActionController::Base
	
  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :no_permission

  private

  	def no_permission
  		flash[:error] = "У вас нет прав доступа к этому ресурсу"
    	redirect_to root_url
  	end

end
