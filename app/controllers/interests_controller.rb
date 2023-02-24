class InterestsController < ApplicationController
  before_action :set_interest, only: %i[new create destroy]

  def index
    @interests = Interest.all
    @bookmarks = Bookmark
  end

  private

  def set_interest
    @interest = Interest.find(params[interest_id])
  end
end
