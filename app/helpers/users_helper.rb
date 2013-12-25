module UsersHelper

  def profile_pic_for(user)
    if user.medium_user_icon_url.nil?
      url = 'http://www.projectnoah.org/images/avatars/avatar-none.jpg'
    else
      url = user.medium_user_icon_url
    end
    image_tag(url, alt: user.name, class: "profile_pic")
  end
end