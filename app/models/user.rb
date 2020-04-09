class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :book_comments, dependent: :destroy
         has_many :following, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
         has_many :followings, through: :following
         has_many :follower, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
         has_many :followers, through: :follower
         def following?(user)
           following.find_by(following_id: user)
         end
         def follow(user_id)
           following.create(following_id: user_id)
         end
         def unfollow(user_id)
           following.find_by(following_id: user_id).destroy
         end
         validates :name,    length: { in: 2..20 }
         validates :introduction,    length: { maximum: 50 }
         validates :postal_code, presence: true
         validates :prefecture_code, presence: true
         validates :city, presence: true
         validates :street, presence: true

         attachment :profile_image

         include JpPrefecture
         jp_prefecture :prefecture_code

         def prefecture_name
           JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
         end
         def prefecture_name=(prefecture_name)
           self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
         end
end
