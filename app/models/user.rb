class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments

  mount_uploader :avatar, PhotoUploader
  validates_presence_of :name

  def admin?
    self.role == "admin"
  end
end
