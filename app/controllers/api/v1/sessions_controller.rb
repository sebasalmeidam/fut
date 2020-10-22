class Api::V1::SessionsController < ApiController

	def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_for_authentication(:email => params[:session][:email])

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_auth_token
      user.save
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.invalidate_auth_token
    user.save
    head 204
  end

end