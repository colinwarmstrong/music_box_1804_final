require 'rails_helper'

describe 'user sees one song' do
  it 'with title and length' do
    artist = Artist.create(name: 'Journey')
    song_1 = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808, rating: 3)
    song_2 = artist.songs.create(title: "Anyway You Want It", length: 420, play_count: 67908, rating: 4)

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
    expect(page).to_not have_content("Rating: #{song_2.rating}")
  end
  it 'they see all genres associated with a song' do
    artist = Artist.create(name: 'Journey')
    song = artist.songs.create(title: "Don't Stop Believing", length: 320, play_count: 390808)
    genre_1 = song.genres.create(name: 'Rock')
    genre_2 = song.genres.create(name: 'Funk')
    genre_3 = song.genres.create(name: 'Jazz')
    genre_4 = Genre.create(name: 'Punk')

    visit song_path(song)

    within('.song-genres') do
      expect(page).to have_content('Genres for this Song:')
      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(genre_3.name)
      expect(page).to_not have_content(genre_4.name)
    end
  end
  it 'they see up to three other songs that have the same rating' do
    artist = Artist.create(name:'Adele')
    song_1 = artist.songs.create(title: "Don't Stop Believin", length: 303, play_count: 123456, rating: 4)
    song_2 = artist.songs.create(title: "Never Gonna Give You Up", length: 253, play_count: 98762452, rating: 4)
    song_3 = artist.songs.create(title: "Everlong", length: 333, play_count: 98762452, rating: 4)
    song_4 = artist.songs.create(title: "Pretenders", length: 283, play_count: 98762452, rating: 4)
    song_5 = artist.songs.create(title: "Hero", length: 423, play_count: 98762452, rating: 4)
    song_6 = artist.songs.create(title: "Monkey Wrench", length: 323, play_count: 98762452, rating: 3)

    visit song_path(song_1)

    within '.songs-with-same-rating' do
      expect(page).to have_content('Songs With Same Rating:')
      expect(page).to have_link(song_2.title)
      expect(page).to have_link(song_3.title)
      expect(page).to have_link(song_4.title)

      expect(page).to_not have_content(song_5.title)
      expect(page).to_not have_content(song_6.title)
    end
  end
end
