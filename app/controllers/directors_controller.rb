class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    d = Director.new
    d.name = params.fetch("the_name")
    d.dob = params.fetch("the_dob")
    d.bio = params.fetch("the_bio")
    d.image = params.fetch("the_image")
    d.save
    redirect_to("/actor")
  end

  def destroy
    the_id = params.fetch("the_id")
    matching = Director.where({ :id => the_id}).first
    matching.destroy
    redirect_to("/directors")
  end

end
