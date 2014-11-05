class Tasks::SetupPilesPlatforms
  def self.execute
    Pile.all.each do |pile|
      pile.attributes["platform_ids"].each do |platform_id|
        piles_platform = PilesPlatform.new({
          pile_id: pile.id,
          platform_id: platform_id
        })
        piles_platform.save
      end
    end
  end
end
