# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(authority: 'guest')
  User.create(name: 'guest', authority: 'guest')
end

[
  'FC', 'SFC', 'VB', 'N64', 'GC', 'Wii', 'WiiU',
  'GB', 'GBC', 'GBA', 'DS', '3DS',
  'PS', 'PS2', 'PS3', 'PS4',
  'PSP', 'PSV',
  'Xbox', 'Xbox360', 'XboxOne',
  'iOS', 'Android', 'WindowsPhone',
  'PC', 'Windows', 'MacOSX', 'Steam', 'Origin',
  'SS', 'DC',
  'WS', 'WSC', 'SwanCrystal'
].each do |platform|
  unless Platform.exists?(name: platform)
    Platform.create(name: platform)
  end
end
