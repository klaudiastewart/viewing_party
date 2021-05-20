class Party < ApplicationRecord
  has_many :party_viewers, dependent: :destroy
  belongs_to :host, class_name: 'User', foreign_key: :host_id
  belongs_to :movie
  
  def movie_title
    self.movie.title
  end
end
