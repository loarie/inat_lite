module SessionsHelper

  def sign_in(key)
    cookies.permanent[:remember_token] = key.remember_token
    user_id = key.user_id
    self.current_user = User.find(user_id)
  end
  
  def signed_in?
    !current_user.nil?
  end
    
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    key = Key.find_by_remember_token(cookies[:remember_token])
    if key.nil?
      return nil
    else
      @current_user ||= User.find(key.user_id)
    end
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def user_and_key_for_token(token)
    headers = {"Authorization" => "Bearer #{token}"}
    response = RestClient.get("#{APP_CONFIG['site']}/users/edit.json", headers)
    user_id = JSON.parse(response)['id']
    user = User.find(user_id)
    if key = Key.where(:token => token).first
      key.update_attributes(:user_id => user.id, :login => user.login, :token => token)
      key.save
    else
      key = Key.create(:user_id => user.id, :login => user.login, :token => token)
    end
    [user, key]
  end

end
