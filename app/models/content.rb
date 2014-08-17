class Content < ActiveRecord::Base
  validates :name, presence: true

  def self.get_content_rankings(content_ids, max = 10)
    content_ids = content_ids.group_by {|id| id}.sort_by {|ids| -ids[1].length}[0...max]

    content_ids.map do |content_id|
      {
        content: find(content_id[0]),
        count: content_id[1].length
      }
    end
  end

  def self.get_nearly_content_rankings(id)

    user_ids = Pile.where(content_id: id).map do |pile|
      user = User.find(pile.user_id)
      user.id
    end

    nearly_pile_ids = user_ids.map do |user_id|
      piles = Pile.where("user_id = #{user_id} && content_id != #{id}")
      piles.map {|pile| pile.content_id}
    end
    nearly_pile_ids.flatten!.uniq!

    get_content_rankings(nearly_pile_ids, 3)
  end

end
