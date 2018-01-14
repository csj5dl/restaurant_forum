class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  #Rails 就會知道 comments table 扮演了 Join Table 的角色
  has_many :restaurants, through: :comments

  mount_uploader :avatar, PhotoUploader
  validates_presence_of :name

  def admin?
    self.role == "admin"
  end
end
