class Tasks::MigratePileId
  def self.execute
    Pile.all.each do |pile|
      next if ContentsPile.find_by(content_id: pile.content_id)
      contents_pile = ContentsPile.new({
        pile_id: pile.id,
        content_id: pile.content_id
      })
      contents_pile.save
    end
  end
end
