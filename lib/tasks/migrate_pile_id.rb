class Tasks::MigratePileId
  def self.execute
    Pile.all.each do |pile|
      if ActiveRecord::Base.connection.column_exists?(:piles, :content_id) && !ContentsPile.find_by(content_id: pile.content_id)
          contents_pile = ContentsPile.new({
            pile_id: pile.id,
            content_id: pile.content_id
          })
        contents_pile.save
      end

      unless ContentsPile.find_by(pile_id: pile.id)
        pile.destroy
      end
    end
  end
end
