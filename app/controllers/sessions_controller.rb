class SessionsController < ApplicationController
  def new
  end
  
  #POST /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #if !@user.nil? && @user.authenticate(params[:session][:password])
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
      #Success
      #log_in(`user)
    else
      #Failure
      flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
