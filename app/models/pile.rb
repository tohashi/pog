class Pile < ActiveRecord::Base
  belongs_to :user
  belongs_to :content
  belongs_to :platform

  validates :user_id, presence: true
  validates :platform_ids, presence: true
  validates :memo, length: (0..40)
  validates :status, presence: true

  serialize :platform_ids, Array

  enum status: {piling: 0, playing: 1, done: 2}

  def self.get_content_ids(time_range = nil)
    piles = all

    if time_range
      piles = piles.reject do |pile|
        pile.updated_at < Time.now - time_range
      end
    end

    piles.map {|pile| pile.content_id}
  end

end
