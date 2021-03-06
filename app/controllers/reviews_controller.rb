class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_song, only: [:new, :create]
  
  # GET /reviews/new
  def new
    @review = @song.reviews.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  # after creating a review, redirect to song the review is for as user does
  # not have access to individual review views
  def create
    @review = @song.reviews.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review.song, notice: t('.notice')}
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  # after updating a review, redirect to song the review is for as user does
  # not have access to individual review views
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review.song, notice: t('.notice')}
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  # after deleting a review, redirect to song the review was for as user does
  # not have access to index of songs
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @review.song, notice: t('.notice')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
    
    def set_song
      @song = Song.find_by(id: params[:song_id]) || Song.find(review_params[:song_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:song_id, :reviewer, :rating, :review)
    end
end
