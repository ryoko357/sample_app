class UsersController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update]
  #before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
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
    @microposts = @user.microposts.paginate(page: params[:page])
    # グローバル変数 @@user = User.first
    # debugger
    
  end
  
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users (+params)
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
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
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # beforeアクション
  
  # ログイン済みユーザーかどうか確認
  #def logged_in_user
  #  unless logged_in?
  #    store_location
  #    flash[:danger] = "Please log in."
  #    redirect_to login_url
  #  end
  #end
  

  # 正しいユーザーかどうかを確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうかを確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
