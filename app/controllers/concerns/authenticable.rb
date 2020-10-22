module Authenticable

  # Devise methods overwrites
  def current_user
    @_current_user ||= authenticate_token
  end

  def authenticate_with_token!
    return true if authenticate_token
    render json: { errors: "Not authenticated" },
                status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end

  protected 
    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end


end