class Tasks::CreatePlatformIds
  def self.execute
    Pile.all.each do |pile|
      next unless pile.platform_ids.empty?
      pile.platform_ids = [pile.platform_id]
      pile.save
    end
  end
end
