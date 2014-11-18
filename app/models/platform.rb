class Platform < ActiveRecord::Base
  has_many :platforms_pile
  has_and_belongs_to_many :piles, :through => :platforms_pile

  validates :name, presence: true

  def self.get_ranking
  end

  def self.get_recomended(limit = 5)
    rankings = Platform.all.sort_by do |platform|
      -platform.piles.size
    end
    rankings[0, limit]
  end
end
