class User
  include Mongoid::Document
  include Mongoid::Paperclip

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy, inverse_of: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many :follows, :dependent => :destroy

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  field :user_name,          type: String
  validates :user_name,
            presence: true,
            length: { minimum: 4, maximum: 16 },
            uniqueness: { :case_sensitive => false }
  validates :email, uniqueness: true

  has_mongoid_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  field :bio, type: String

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time

  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  def follow!(user)
    follows.create(followed_user: user)
  end

  def unfollow!(user)
    follows.where(followed_user_id: user.id).destroy
  end

end
