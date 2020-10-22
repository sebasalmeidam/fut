class Api::V1::UsersController < ApiController
	before_action :authenticate_with_token!, except: [:create]
	respond_to :json

	def index
    if current_user
      redirect_to action: "show", id: current_user
    end
  end

  def show
		user = current_user
		players = user.players.count
    @response = {user: user, players: players}
    respond_with @response
	end

	def create
		user = User.new(user_params)
    if user.save
      user.generate_auth_token
      sign_in user, store: false
      render json: user, status: 201, location: api_user_path(user)
    else
      render json: { errors: user.errors }, status: 422
    end
	end

	def update
  user = current_user

  if user.update(user_params)
    render json: {flash: "Usuario ha sido actualizado"}, status: 200, location: api_user_path(user)
  else
    render json: { errors: user.errors }, status: 422
  end
end

	private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

end