class Movie < ActiveRecord::Base
def self.all_rating
  all_rating_hs={}
  all_rating=[]
  movies=Movie.all
  movies.each do |movie|
  if !all_rating_hs.has_key?(movie.rating)
    all_rating_hs[movie.rating]=movie.rating
    all_rating.push movie.rating
  end
  end 
 all_rating
end
end
