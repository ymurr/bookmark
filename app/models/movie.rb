class Movie < ActiveRecord::Base
  #when a movie is deleted, all the comments for this movie is also deleted
  has_many :comments, :dependent => :destroy
  validates_presence_of :name, :director
  validates_numericality_of :year, :length, :greater_than => 0
  validates_uniqueness_of :name, :message => "Already used!"
  #validates_length_of :format, :maximum => 5, :minimum => 2
  paginates_per 5  #5 per page

   def proper_name
     name.titleize
   end

end
