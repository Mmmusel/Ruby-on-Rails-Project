class StarsController < ApplicationController
  before_action :set_star, only: %i[ show edit update destroy ]

  # GET /stars or /stars.json
  def index
    @stars = Star.all
  end

  # GET /stars/1 or /stars/1.json
  def show
  end

  # GET /stars/new
  def new
    @star = Star.new
  end

  # GET /stars/1/edit
  def edit
  end

  # POST /stars or /stars.json

    def create
	  @star = Star.new()
	    blog=Blog.find(params[:blog_id])
	    @star.user=current_user
	    @star.blog=blog
	  	

    respond_to do |format|
      if @star.save
        format.html { redirect_to blog_url(blog), notice: "star was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stars/1 or /stars/1.json
  def update
    respond_to do |format|
      if @star.update(star_params)
        format.html { redirect_to star_url(@star), notice: "Star was successfully updated." }
        format.json { render :show, status: :ok, location: @star }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1 or /stars/1.json
  def destroy
  blog=Blog.find(@star.blog_id)
    @star.destroy

    respond_to do |format|
      format.html { redirect_to blog_url(blog), notice: "Star was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_star
      @star = Star.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def star_params
      params.require(:star).permit(:blog_id, :user_id)
    end
end
