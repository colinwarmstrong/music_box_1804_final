require 'rails_helper'

describe 'user sees one song' do
  it 'with title and length' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808)
    song_2 = artist.songs.create(title: "Anyway You Want It", length: 420, play_count: 67908)

    visit song_path(song_1)

    expect(current_path).to eq("/songs/#{song_1.slug}")

    expect(page).to have_content(song_1.title)
    expect(page).to have_content(song_1.length)
    expect(page).to_not have_content(song_2.title)
    expect(page).to_not have_content(song_2.length)
  end
  it 'with numeric rating for this song' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating: 1)
    song_2 = artist.songs.create(title: "Anyway You Want It", length: 420, play_count: 67908, rating: 5)

    visit song_path(song_1)

    expect(page).to have_content("Rating: #{song_1.rating}")
  end
  it 'they see all genres associated with a song' do
    artist = Artist.create(name: 'Journey')
    song = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808)
    genre_1 = song.genres.create(name: 'Rock')
    genre_2 = song.genres.create(name: 'Funk')
    genre_3 = Genre.create(name: 'Punk')

    visit song_path(song)

    within('.song-genres') do
      expect(page).to have_content('Genres for this Song:')
      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to_not have_content(genre_3.name)
    end
  end
end
