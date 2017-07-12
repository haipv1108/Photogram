module RelationshipsHelper
  def current_user_is_following(current_user, user)
    relationship = Follow.find_by(user_id: current_user.id, followed_user_id: user.id)
    return true if relationship
    return false if relationship.nil?
  end
end
