class Comment < ActiveRecord::Base
  belongs_to :movie
  validates_presence_of :author, :content

  #class method
  def self.descending
    order(:created_at => :desc)

  end

end
