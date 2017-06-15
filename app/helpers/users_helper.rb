module UsersHelper

  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                           id: 'image-preview',
                                  class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-image.jpg',
              id: 'image-preview',
                     class: 'img-responsive img-circle profile-image'
  end
end