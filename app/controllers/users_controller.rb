class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    if @user.observations_count > 0
      @observations = Observation.find(:all, :from => "/observations/#{@user.login}.json")
    end
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
      sign_in key
      flash[:success] = "Welcome to iNaturalist!"
      redirect_to @user
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @errors = []
  end
  
  def update
    @user = User.find(params[:id])
    @errors = []
    key = Key.where(:user_id => @user.id). first
    token = key.token
    headers = { "Authorization" => "Bearer #{token}" }
    payload = { 'user[login]' => params[:user][:login],'user[description]' => params[:user][:description],'user[password]' => params[:user][:password] }
    begin
      response = RestClient.put("#{ENV['SITE']}/users/#{@user.id}.json", payload, headers)
      flash[:success] = "Profile updated"
      sign_in key
      redirect_to @user
    rescue RestClient::UnprocessableEntity, RestClient::Unauthorized => e
      flash.now[:error] = "Error updating profile"
      render 'edit'
    end
  end
  
  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end


