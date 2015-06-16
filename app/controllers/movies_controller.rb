class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :mail, :spam]
  before_filter :authenticate, except: [:index, :show]

  def mail  #mail_movie_path
    UserMailer.newsletter(@movie, current_user).deliver_now
    redirect_to @movie, notice: 'Email sent.'
  end


  def spam  #spam_movie_path
    #get all users, loop thru and send email to each
    #users = User.where (:newsletter => true)
    users = User.all

    users.each do |user|
      UserMailer.newsletter(@movie, user).deliver_now!
    end
    redirect_to movies_path, notice: 'Email sent.'
  end


  # GET /movies
  # GET /movies.json
  def index
    @page = params['page']
    # @prev_page = @page - 1 unless @page == 0
    # @next_page = @page + 1 unless (@page * 5 > Movie.count)
    # @movies = Movie.limit(5).offset(@page * 5).order(:id => :desc)
    @movies = Movie.page(@page).order(:id => :desc)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @comment = Comment.new
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def authenticate
    authenticate_user! && current_user.admin?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :director, :description, :year, :length, :format, :image, :thumbnail)
    end
end
