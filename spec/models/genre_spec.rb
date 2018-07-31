require 'rails_helper'

describe Genre, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should have_many :song_genres}
    it {should have_many :songs}
  end
  describe 'instance methods' do
    it '#average_song_rating' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      artist = Artist.create(name: 'Foo Fighters')
      song_1 = genre_1.songs.create(title: 'Everlong', length: 240, play_count: 6600, artist_id: artist.id, rating: 1)
      song_2 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 3)
      song_3 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 5)
      song_4 = genre_2.songs.create(title: 'Pretenders', length: 360, play_count: 8100, artist_id: artist.id, rating: 5)

      expect(genre_1.average_song_rating).to eq(3)
    end
    it '#highest_rated_song' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      artist = Artist.create(name: 'Foo Fighters')
      song_1 = genre_1.songs.create(title: 'Everlong', length: 240, play_count: 6600, artist_id: artist.id, rating: 1)
      song_2 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 3)
      song_3 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 4)
      song_4 = genre_2.songs.create(title: 'Pretenders', length: 360, play_count: 8100, artist_id: artist.id, rating: 5)

      expect(genre_1.highest_rated_song).to eq(song_3)
    end
  end
end
