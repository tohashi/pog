class Content < ActiveRecord::Base
  has_many :contents_piles
  has_many :piles, :through => :contents_piles

  validates :name, presence: true

  def self.get_ranking(content_ids, max = 10)
    content_ids = content_ids.group_by {|id| id}.sort_by {|ids| -ids[1].length}[0...max]

    content_ids.map do |content_id|
      {
        content: find(content_id[0]),
        count: content_id[1].length
      }
    end
  end

  def self.get_nearly_contents(id)
    # TODO has_namy through
    nearly_content_ids = Content.find(id).piles.map do |pile|
      user = User.find(pile.user_id)
      user.piles.map {|pile| pile.content.id}
    end

    nearly_content_ids = nearly_content_ids.flatten.uniq.reject {|content_id| content_id == id}
    content_list = nearly_content_ids.group_by {|id| id}.sort_by {|ids| -ids[1].length}[0...3]

    content_list.map do |content|
      find(content[0])
    end
  end
end
