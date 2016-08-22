class User < ApplicationRecord
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_many :joinedevents, :dependent=>:destroy #relationship table
  has_many :events # events user created, has foreign key user (host)
  has_many :joiningevents, through: :joinedevents, source: :event # events user is joining
  has_many :discussions
  has_secure_password
  validates :first_name, :last_name, :email, :location, :state, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
