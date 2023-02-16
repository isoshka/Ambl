class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [ :new, :create, :destroy ]

  def index
    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    @interests = []
    @my_bookmarks.each do |bookmark|
      @interests << bookmark.interest
    end
    @interests
  end

  def new

  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
  end

  def destroy
    @bookmark.destroy
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.find(params[:id])
  end

end
