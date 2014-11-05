class PilesPlatform < ActiveRecord::Base
  belongs_to :pile
  belongs_to :platform
end
