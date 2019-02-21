class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  # 自己紹介文は50文字以内
  validates :introduction, length: {maximum: 50}
  has_many :books, dependent: :destroy
  attachment :profile_image
end
