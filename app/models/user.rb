class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def friend_requests_from_me
    friendships.map { |invitation| invitation.friend unless invitation.confirmed }.compact
  end

  def friend_requests_to_me
    inverse_friendships.map { |invitation| invitation.user unless invitation.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |frship| frship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def decline_friend(user)
    friendship = inverse_friendships.find { |frship| frship.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end
