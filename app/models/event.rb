class Event < ApplicationRecord
  belongs_to :user
  has_many :joinedevents, :dependent=>:destroy
  has_many :attendees, through: :joinedevents, source: :user
  has_many :discussions
  validates :name, :date, :location, :state, presence: true
end
