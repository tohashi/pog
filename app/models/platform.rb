class Platform < ActiveRecord::Base
  # has_and_belongs_to_many :platforms

  validates :name, presence: true

  def self.get_ranking
  end
end
