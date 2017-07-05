class Follow
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :followed_user, class_name: 'User'
end