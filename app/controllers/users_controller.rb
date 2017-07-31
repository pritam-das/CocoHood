class UsersController < ApplicationController

def new
  @user = User.new
end

# Fetches list of users based on search terms. Shows all users by default.
# Retrieval method is written in the models file.
def index
  @users = User.search(params[:search])
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

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])

  if @user.update_attributes(user_params)
    flash[:notice] = 'User profile updated succesfully'
    redirect_to user_path(@user)
  end

end



private
def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :name, :address, :avatar, :bio, :interests, :username => [])
end


end
