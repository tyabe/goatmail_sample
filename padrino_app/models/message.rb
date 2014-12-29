class Message
  include ActiveModel::Model

  attr_accessor :subject, :body, :attachment

  validates :subject, presence: true
  validates :body,    presence: true
end
