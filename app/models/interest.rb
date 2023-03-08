class Interest < ApplicationRecord
  has_many :places
  has_one :bookmark, dependent: :destroy
  INTERESTS = { ramen: "fa-bowl-food", cafe: "fa-mug-hot", "cocktail-bar": "fa-martini-glass-citrus", nightclub: "fa-compact-disc" }
end
