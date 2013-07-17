class Backend::ApplicationController < ApplicationController
	protect_from_forgery
	load_and_authorize_resource
	layout 'backend/backend'
end