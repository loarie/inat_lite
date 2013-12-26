class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
    
  def new
    @errors = []
    @user = User.new(:login => params[:login], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
  end
  
  def create
    @user = User.new(params[:user])
    @errors = []
    begin
      @user.save
    rescue ArgumentError => e
      reg = /\"(.*?)\"/
      e.message.scan(reg).each do |err|
        @errors << err[0]
      end
    end    
    if @errors.any?
      render 'new'
    else
      client = OAuth2::Client.new(ENV['APP_ID'], ENV['APP_SECRET'], :site => ENV['SITE'])
      token = client.password.get_token(params[:user][:login], params[:user][:password]).token
      @user, key = user_and_key_for_token(token)
      flash[:success] = "Welcome to iNaturalist!"
      redirect_to @user
    end
  end
end
