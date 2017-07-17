class UsersController < ApplicationController

def new
  @user = User.new
end

def index
  @users = User.all
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
  end
end

def show
  @users = User.all
  @user = User.find(params[:id])
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.latitude
    marker.lng user.longitude
    marker.infowindow user.bio
    marker.json({title: user.name})
  end
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
  params.require(:user).permit(:email, :password, :password_confirmation, :name, :address, :avatar, :bio, :interests => [])
end


end
