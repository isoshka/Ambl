class Place < ApplicationRecord
  belongs_to :interest

  has_one_attached :photo
end
