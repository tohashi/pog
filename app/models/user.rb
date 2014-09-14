class User < ActiveRecord::Base
  has_many :piles

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

end
