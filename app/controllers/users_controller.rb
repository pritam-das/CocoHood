class UsersController < ApplicationController

def new
  @user = User.new
end

def index
  @users = User.all
end

def show
  @user = User.find(params[:id])
end

def create
  @user = User.new(user_params)

  if @user.save
  flash[:notice] = 'Signed up succesfully!'
  session[:user_id] = @user.id
  redirect_to root_url
else
  render :new
end

end

private
def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :bio)
end


end
