class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :no_permission

  def routing_error
    render status: 404, template: "/errors/route_error.html.haml", layout: false
    false
  end

  private

  	def no_permission
  		flash[:error] = "У вас нет прав доступа к этому ресурсу"
    	redirect_to root_url
  	end

end
