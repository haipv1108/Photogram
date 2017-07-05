class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  field :identifier, type: Integer
  field :notice_type, type: String
  field :read, type: Boolean, default: false
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :post

end
