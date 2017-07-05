module RelationshipsHelper
  def current_user_is_following(current_user, user)
    relationship = Follow.find_by(user_id: current_user, followed_user_id: user)
    true if relationship
  end
end
