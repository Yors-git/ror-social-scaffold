module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def check_current_user
    sign_out_btn =  (link_to 'Sign out', destroy_user_session_path, method: :delete)
    if signed_in?
      (link_to "Logged as: #{current_user.name}", user_path(current_user), method: :get) + sign_out_btn
    else
      link_to 'Sign in', user_session_path
    end
  end

  def show_messages    
    result = ''    
    result += "<div class='notice'><p> #{notice} </p></div>"  if notice.present?
    result += "<div class='notice'><p> #{alert} </p></div>" if alert.present?
    result.html_safe  
  end

  def invite_friend_index(user)
    if !user.friends.include?(current_user) && user != current_user && !user.pending_friends.include?(current_user) && !user.friend_requests.include?(current_user)
      button_to 'Invite friend', create_freindship_user_path(user.id), method: :get
    end
  end
end
