class Song < ApplicationRecord
  validates_presence_of :title, :length, :play_count
  belongs_to :artist
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  has_many :song_genres
  has_many :genres, through: :song_genres

  before_save :generate_slug


  def to_param
    slug
  end

  def generate_slug
    self.slug = title.parameterize
  end

  def songs_with_same_rating
    Song.where(rating: rating).where.not(id: id).limit(3)
  end
end
