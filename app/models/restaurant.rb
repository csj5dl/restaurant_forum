class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  belongs_to :category
  has_many :comments, dependent: :destroy

  # 「使用者收藏很多餐廳」的多對多關聯
  # 由於使用 users 會和「使用者評論很多餐廳」重覆，將關聯名稱自訂為 :favorited_users
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
end
