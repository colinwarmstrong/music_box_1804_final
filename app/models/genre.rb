class Genre < ApplicationRecord
  validates_presence_of :name
  has_many :song_genres
  has_many :songs, through: :song_genres

  def average_song_rating
    songs.average(:rating)
  end

  def highest_rated_song
    songs.order(rating: :desc).limit(1).take
  end

  def lowest_rated_song
    songs.order(rating: :asc).limit(1).take
  end
end
