class Platform < ActiveRecord::Base
  validates :name, presence: true

  def self.get_ranking
  end
end
