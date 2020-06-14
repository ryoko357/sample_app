class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update]
  #before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]
  
  # GET /users/:id
  def index
    @users = User.paginate(page: params[:page])
  end
  
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
      @user.send_activation_email
      #UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      #success
      #log_in @user
      #flash[:success] = "Welcom to the Sample App!"
      # GET "users/#{@user.id}"
      #redirect_to @user
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1) => /users/1      
    else
      #failure
      render 'new'
    # => name, email, pass/confirmation
    end
  end
  
  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
    # => app/view/users/edit.html.erb
  end
  
  #PARCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新に成功した場合を扱う。
        flash[:success] = "Profile updated"
        redirect_to @user
    else
      # @users.errors <== ここにデータが入っている
      render 'edit'
    end
  end
  
  #DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # beforeアクション
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
