class Post
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps

  belongs_to :user, inverse_of: :post
  has_many :comments, dependent: :destroy

  field :caption, type: String
  has_mongoid_attached_file :image, styles: { :medium => "640x" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :caption, presence: true, length: { minimum: 3, maximum: 300 }
  validates :image, presence: true
  validates :user_id, presence: true
end
