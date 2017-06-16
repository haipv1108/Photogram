module PostsHelper

  def form_image_select(post)
    return image_tag post.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive' if post.image.exists?
    image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type(User)
    return list_likers(votes) if votes.count <= 8
    count_likers(votes)
  end

  def liked_post(post)
    return 'glyphicon-heart' if current_user.voted_for? post
    'glyphicon-heart-empty'
  end

  def display_link_like(post)
    return link_to '', unlike_post_path(post.id),
                   remote: true,
                   class: "glyphicon #{liked_post post}" if current_user.voted_for? post
    link_to '', like_post_path(post.id),
                   remote: true,
                   class: "glyphicon #{liked_post post}"
  end

  private

    def like_plural(votes)
      return ' like this' if votes.count > 1
      ' likes this'
    end

    def list_likers(votes)
      user_names = []
      unless votes.blank?
        votes.voters.each do |voter|
          user_names.push(link_to voter.user_name,
                                  profile_path(voter.user_name),
                                  class: 'user-name')
        end
        user_names.to_sentence.html_safe + like_plural(votes)
      end
    end

    def count_likers(votes)
      vote_count = votes.size
      vote_count.to_s + ' likes'
    end
end