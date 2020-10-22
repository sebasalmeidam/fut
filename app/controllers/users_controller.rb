class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_admin

  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  		redirect_to users_path
  	else
  		flash.now[:notice] = "Usuario no ha sido creado."
  		render 'new'
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])

  	if @user.update_attributes(user_params)
  		redirect_to users_path
  	else
  		flash.now[:notice] = "Usuario no ha sido editado."
  		render 'edit'
  	end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	flash[:notice] = "El usuario: #{@user.name} ha sido eliminado."
  	redirect_to users_path
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email)
  end

  def set_admin
    unless current_user.admin
      flash[:warning] = "Ha sido redireccionado."
      redirect_to players_path
    end
  end

end
