class User < ActiveRecord::Base
  has_many :piles, :dependent => :destroy

  validates :name, presence: true

  enum authority: {guest: 0, registrant: 1, admin: 2}

  def self.create_with_auth(auth)
    # with execption
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
    end
  end

  def self.find_by_uid(auth)
    user = find_by(provider: auth['provider'], uid: auth['uid'])
    if user.name != auth['info']['nickname']
      user.save! do |user|
        user.name = auth['info']['nickname']
      end
    end
    user
  end
end
