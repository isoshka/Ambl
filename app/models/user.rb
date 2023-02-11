class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  FREQUENCY = ['30 minutes', '1 hour', '2 hours']
  DISTANCE = ['500 meters', '800 meters', '1km']

  has_one_attached :photo

end
