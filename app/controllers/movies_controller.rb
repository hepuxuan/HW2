class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index 
  first=true
  where=''
  redirect=false
  sort=-1
  if params[:sort]
    sort = params[:sort]
    session[:sort]=sort
    elsif session[:sort]
    sort=session[:sort] 
    redirect=true
  end
  if params[:ratings] 
  ratings=params[:ratings]
  session[:ratings]=ratings
  elsif session[:ratings]
  ratings=session[:ratings]
  redirect=true
  end
  if redirect
    flash.keep
    redirect_to movies_path(:ratings=>ratings,:sort=>sort)
  end
  if ratings
  ratings.each do |key,value|
    if first
          where+='rating=\''+key.to_s+'\''
          first=false
        else where+=' or rating=\''+key.to_s+'\''
     end
  end
  end
  if where!=''
    @movies=Movie.where(where)  
  else
    @movies=Movie.all
  end
    @all_ratings=Movie.all_rating
    
    if sort
    if sort=='1'
      @movies.sort!{|a,b| a.title<=>b.title}
      @hilite=1
    elsif sort=='2'
      @movies.sort!{|a,b| a.release_date<=>b.release_date}
      @hilite=2
    
    end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
