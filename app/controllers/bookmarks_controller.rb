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

  def nearby
    latitude = params[:latitude]
    longitude = params[:longitude]

    @client = Twilio::REST::Client.new(ENV["ACb769755c7641b99bcf1b35f55dfa759f"], ENV["7f08a71e1b0a2a8885bfdd29eb4d0f17"])
    # # get the nearby bookmarks
    @interest_ids = []
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @bookmarks.each do |bookmark|
      @interest_ids << bookmark.interest_id
    end

    # @places = Place.near([latitude, longitude], 3).where(interest_id: @interest_ids)
    @places = Place.near([latitude, longitude], 3, latitude: :lat, longitude: :lng).where(interest_id: @interest_ids)
    @places.each do |place|
      message = "Hey, you're near #{place.name} at #{place.address}. Check out this photo: #{place.google_photo_url}"
          @client.messages.create(
            from: ENV['+16208328198'],
            to: current_user.phone_number,
            body: message
          )
        end
    render json: @places
      # current_user.interests


    # @nearby_bookmarks = Bookmark.near([latitude, longitude], 3)
    # # within 3 kilometers send a message to whatsapp with the bookmarks name
    # @nearby_bookmarks.each do |bookmark|
    #   if bookmark.interest.user_id == current_user.id
    #     message = client.messages.create(
    #       from: ENV['+16208328198'],
    #       to: current_user.phone_number,
    #       body: "Hey, you're near a place of interest!"
    #     )
    #   end
    # end
  end

  def destroy
    @bookmark.destroy
  end

  private

  def set_bookmark
    @bookmarks = Bookmark.find(params[:id])
  end

end
