class ContentsPile < ActiveRecord::Base
  belongs_to :content
  belongs_to :pile
end
