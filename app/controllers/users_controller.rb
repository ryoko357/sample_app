class UsersController < ApplicationController
  # GET /users/:id
  def show
    # ローカル変数 show(controller)の外では使えない user = User.first
    # インスタンス変数 viewの中では使える
    @user = User.find(params[:id])
    # グローバル変数 @@user = User.first
    # debugger
    
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users (+params)
  def create
    # (@user + given params).save
    @user = User.new(user_params)
    if @user.save
      #success
      log_in @user
      flash[:success] = "Welcom to the Sample App!"
      # GET "users/#{@user.id}"
      redirect_to @user
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1) => /users/1      
    else
      #failure
      render 'new'
    # => name, email, pass/confirmation
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
