class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments, dependent: :restrict_with_error
  #Rails 就會知道 comments table 扮演了 Join Table 的角色
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  # 由於使用 restaurants 會和「使用者評論很多餐廳」重覆，將關聯名稱自訂為 :favorited_restaurants
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  # has_many :favorites, class_name: "favorite", primary_key: "id", foreign_key: "user_id"
  #           方法命名    關聯資料表格名稱           自己主KEY            對方的外KEY
  #has_many :favorited_restaurants, through: :favorites, source: :restaurant
  #          方法命名                 中間表名稱            來源關聯名稱

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 使用者追蹤使用者
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 使用者的追蹤者
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  mount_uploader :avatar, PhotoUploader
  validates_presence_of :name

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
end
