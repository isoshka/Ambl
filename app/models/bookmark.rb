class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :interest
  validates :interest, uniqueness: { scope: :user, message: "interest already selected" }
end
