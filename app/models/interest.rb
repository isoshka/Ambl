class Interest < ApplicationRecord
  has_many :places
  has_one :bookmark, dependent: :destroy
end
