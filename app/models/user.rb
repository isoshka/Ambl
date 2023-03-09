class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  FREQUENCY = ['30 minutes', '1 hour', '2 hours']
  DISTANCE = ['100 meters', '500 meters', '1km']

  has_one_attached :photo
  acts_as_favoritor
  has_many :bookmarks, dependent: :destroy
end
