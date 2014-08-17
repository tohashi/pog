class Pile < ActiveRecord::Base
  belongs_to :user
  belongs_to :content
  belongs_to :platform

  validates :user_id, presence: true
  validates :platform_ids, presence: true
  validates :memo, presence: true

  serialize :platform_ids, Array
end
