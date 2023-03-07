class Interest < ApplicationRecord
  has_many :places
  has_one :bookmark, dependent: :destroy

  ICONS = {
    ramen: 'fa-2x fa-solid fa-bowl-food',
    cafe: 'fa-2x fa-solid fa-mug-saucer',
    cocktail: 'fa-2x fa-solid fa-martini-glass-citrus',
    nightclub: 'fa-2x fa-solid fa-champagne-glasses'
  }
end
