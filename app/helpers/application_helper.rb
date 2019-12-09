module ApplicationHelper
  def user_avatar user
    user.image.present? ? user.image.url : "avatar_icon.png"
  end
end
