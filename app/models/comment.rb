class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  belongs_to :user
  belongs_to :post

  validates :content, :user_id, :post_id, presence: true
end
