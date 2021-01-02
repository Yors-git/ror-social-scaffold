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
    sign_out_btn = (link_to 'Sign out', destroy_user_session_path, method: :delete)
    if signed_in?
      (link_to "Logged as: #{current_user.name}", user_path(current_user), method: :get) + sign_out_btn
    else
      link_to 'Sign in', user_session_path
    end
  end

  def show_messages
    result = ''
    result += "<div class='notice'><p> #{notice} </p></div>" if notice.present?
    result += "<div class='notice'><p> #{alert} </p></div>" if alert.present?
    result.html_safe
  end

  # rubocop: disable Style/GuardClause, Layout/LineLength
  def invite_friend_index(user)
    if !user.friends.include?(current_user) && user != current_user && !user.pending_friends.include?(current_user) && !user.friend_requests.include?(current_user)
      button_to 'Invite friend', create_freindship_user_path(user.id), method: :get
    end
  end

  def invite_friend_show(user, pending_inv, pending_req)
    if !user.friends.include?(current_user) && user.id != current_user.id && !pending_inv.include?(current_user) && !pending_req.include?(current_user)
      button_to 'Invite friend', create_freindship_user_path, method: :get
    end
  end

  def accept_and_decline_btns(usr)
    if @user.id == current_user.id
      (button_to 'Accept', accept_user_path, method: :get, params: { data: usr }) +
        (button_to 'Decline', decline_user_path, method: :get, params: { data: usr }, class: 'red_button')
    end
  end
  # rubocop: enable Style/GuardClause, Layout/LineLength
end
