class Post
  include Mongoid::Document
  include Mongoid::Paperclip

  belongs_to :user, dependent: :destroy, inverse_of: :post
  has_many :comments, dependent: :destroy

  field :caption, type: String
  has_mongoid_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :caption, :user_id, presence: true
  validates :image, presence: true
end
