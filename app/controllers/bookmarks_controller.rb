class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[new create destroy]

  def index
    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    @interests = []
    @my_bookmarks.each do |bookmark|
      @interests << bookmark.interest
    end
    @my_bookmarks
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    # @my_bookmarks = Bookmark.where(user_id: current_user.id)
    # if @my_bookmarks.length < 3
    # new_bookmark_params = bookmark_params
    # new_bookmark_params[:user_id] = current_user.id
    # @my_bookmarks.each do |bookmark|
    # not_unique = (bookmark.interest.id == new_bookmark_params[:interest_id].to_i)
    # return "Try another one." if not_unique
    # end
    # @bookmark = Bookmark.new(new_bookmark_params)
    # if @bookmark.save
    # redirect_to bookmarks_path
    # else
    # render :new
    # end
    # else
    # "Limit reached, sorry."
    # end

    @my_bookmarks = Bookmark.where(user_id: current_user.id)
    if @my_bookmarks.length < 4
      new_bookmark_params = bookmark_params
      new_bookmark_params[:user_id] = current_user.id
      @my_bookmarks.each do |bookmark|
        not_unique = (bookmark.interest.id == new_bookmark_params[:interest_id].to_i)
        return "Try another one." if not_unique
      end
      @bookmark = Bookmark.new(new_bookmark_params)
      if @bookmark.save
        redirect_to bookmarks_path
      else
        render :new
      end
    else
      "Limit reached, sorry."
    end

    # this is how to create Bookmark.create(interest_id: 8, user_id: 6)

    # how does this code fit in?
    # @existing_interests = Bookmark.find(params[:user_id])
    # @existing_interests.length
    # if @existing_interests.length > 3
    # return “You can only pick 3 interests”
    # else < 3
    # @interests = params[:interests]
    # @interests.each do |interest|
    # @existing_interests find it exist
    # if it doesnt save
    # end
    # if @interests.length > 3
    # return “You can only pick 3 interests”
    # else < 3
  end

  def destroy
    @bookmark.destroy
    redirect_to interests_path(@bookmark.list), status: :see_other
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def bookmark_params
    params.require(:bookmark).permit(:interest_id)
  end
end
