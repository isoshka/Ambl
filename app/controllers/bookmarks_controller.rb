class BookmarksController < ApplicationController
  before_action :set_bookmark, only[:create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
  end
end
