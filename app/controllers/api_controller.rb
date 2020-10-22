class ApiController < ApplicationController

	include ActionController::HttpAuthentication::Token::ControllerMethods

	protect_from_forgery with: :null_session,
      if: Proc.new { |c| c.request.format =~ %r{application/json} }
	include Authenticable

end