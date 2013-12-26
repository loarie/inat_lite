class SessionsController < ApplicationController

  def new
  end

  def create
    client = OAuth2::Client.new(ENV['APP_ID'], ENV['APP_SECRET'], :site => ENV['SITE'])
    begin
      token = client.password.get_token(params[:session][:login], params[:session][:password]).token
      user, key = user_and_key_for_token token
      sign_in key
      
      flash[:success] = "Welcome back #{user.login}!"
      redirect_to user
    rescue OAuth2::Error => e
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end