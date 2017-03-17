class Goal < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  # validates :name, presence: true
end
