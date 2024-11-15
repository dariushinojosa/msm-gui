class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def insert

    m = Movie.new
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_desc")
    m.image = params.fetch("the_image")
    m.director = params.fetch("the_director")
    m.save

    redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("the_id")
    matching = Movie.where({ :id => the_id}).first
    matching.destroy
    redirect_to("/movies")
  end
end
