class InterestsController < ApplicationController
  def index
    @interests = Interest.all
    @bookmarks = Bookmark
  end
end
