require 'rails_helper'

describe "A user visits '/genres/:id'" do
  describe 'as a visitor' do
    it 'they see all songs associated with that genre' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      artist = Artist.create(name: 'Foo Fighters')
      song_1 = genre_1.songs.create(title: 'Everlong', length: 240, play_count: 6600, artist_id: artist.id)
      song_2 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id)
      song_3 = genre_2.songs.create(title: 'Pretenders', length: 360, play_count: 8100, artist_id: artist.id)

      visit genre_path(genre_1)

      expect(page).to have_content(song_1.title)
      expect(page).to have_content("Length: #{song_1.length}")
      expect(page).to have_content("Play Count: #{song_1.play_count}")

      expect(page).to have_content(song_2.title)
      expect(page).to have_content("Length: #{song_2.length}")
      expect(page).to have_content("Play Count: #{song_2.play_count}")

      expect(page).to_not have_content(song_3.title)
      expect(page).to_not have_content("Length: #{song_3.length}")
      expect(page).to_not have_content("Play Count: #{song_3.play_count}")
    end
    it 'they see the average rating for all songs in this genre' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      artist = Artist.create(name: 'Foo Fighters')
      song_1 = genre_1.songs.create(title: 'Everlong', length: 240, play_count: 6600, artist_id: artist.id, rating: 1)
      song_2 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 3)
      song_3 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 5)
      song_4 = genre_2.songs.create(title: 'Pretenders', length: 360, play_count: 8100, artist_id: artist.id, rating: 5)

      visit genre_path(genre_1)

      expect(page).to have_content("Average Song Rating: 3")
    end
    it 'they see the name and rating of the song with the highest rating of all songs in this genre' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      artist = Artist.create(name: 'Foo Fighters')
      song_1 = genre_1.songs.create(title: 'Everlong', length: 240, play_count: 6600, artist_id: artist.id, rating: 1)
      song_2 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 3)
      song_3 = genre_1.songs.create(title: 'Hero', length: 330, play_count: 7900, artist_id: artist.id, rating: 4)
      song_4 = genre_2.songs.create(title: 'Pretenders', length: 360, play_count: 8100, artist_id: artist.id, rating: 5)

      visit genre_path(genre_1)

      within('.highest-rated-song') do
        expect(page).to have_content("Highest Rated Song: #{song_3.title}")
        expect(page).to have_content("Rating: #{song_3.rating}")
      end  
    end
  end
end
