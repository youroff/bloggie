module ApplicationHelper

  def render_username (user)
    link_to user.username, blog_path(user.id)
  end

end
