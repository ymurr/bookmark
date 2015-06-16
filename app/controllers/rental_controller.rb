class RentalController < ApplicationController
  def index
    @page = params['page']
    # @prev_page = @page - 1 unless @page == 0
    # @next_page = @page + 1 unless (@page * 5 > Movie.count)
    # @movies = Movie.limit(5).offset(@page * 5).order(:id => :desc)
    @movies = Movie.page(@page).order(:id => :desc)
  end

  def show
    @movie = Movie.find(params['id'])
  end
end
