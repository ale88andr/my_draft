class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied, with: :no_permission

  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| routing_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| routing_error 404, exception }
  #end

  def error_from_route
    routing_error 404
  end

  private

    def routing_error(status, exception = nil)
      @not_found_path = request.url
      render status: status, template: "/errors/route_error_#{status}.html.haml", layout: false
      false
    end

  	def no_permission
  		flash[:error] = "У вас нет прав доступа к этому ресурсу"
    	redirect_to root_url
  	end

end
