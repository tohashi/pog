class Pile < ActiveRecord::Base
  has_one :contents_pile
  has_one :content, :through => :contents_pile
  # has_and_belongs_to_many :platforms

  belongs_to :user

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

    piles.map {|pile| pile.content.id}
  end
end
