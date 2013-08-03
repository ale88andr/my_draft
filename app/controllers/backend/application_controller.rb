class Backend::ApplicationController < ApplicationController
	protect_from_forgery
  before_filter :authenticate_user!
	load_and_authorize_resource
	layout 'backend/backend'
end