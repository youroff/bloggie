module ApplicationHelper

  def render_username (user)
    link_to user.username, blog_path(user.id)
  end

  def render_userlist (users)
  	if !users.empty?
  		(users.map { |u| render_username u }).join(', ').html_safe
  	else
  		'(none)'
  	end
  end

  def is_my_friend (user)
  	Friendship.exists?(user_id: current_user.id, friend_id: user.id)
  end

end
