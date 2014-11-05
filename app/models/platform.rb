class Platform < ActiveRecord::Base
  has_many :platforms_pile
  has_and_belongs_to_many :piles, :through => :platforms_pile

  validates :name, presence: true

  def self.get_ranking
  end
end
