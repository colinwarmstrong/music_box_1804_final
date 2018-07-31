require 'rails_helper'

describe Song, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:title)}
    it{should validate_presence_of(:length)}
    it{should validate_presence_of(:play_count)}

  end

  describe 'relationships' do
    it{should belong_to(:artist)}
    it{should have_many :song_genres}
    it{should have_many :genres}
  end

  describe 'instance methods' do
    it '#songs_with_same_rating' do
      artist = Artist.create(name:'Adele')
      song_1 = artist.songs.create(title: "Don't Stop Believin", length: 303, play_count: 123456, rating: 4)
      song_2 = artist.songs.create(title: "Never Gonna Give You Up", length: 253, play_count: 98762452, rating: 4)
      song_3 = artist.songs.create(title: "Everlong", length: 333, play_count: 98762452, rating: 4)
      song_4 = artist.songs.create(title: "Pretenders", length: 283, play_count: 98762452, rating: 4)
      song_5 = artist.songs.create(title: "Hero", length: 423, play_count: 98762452, rating: 4)
      song_6 = artist.songs.create(title: "Monkey Wrench", length: 323, play_count: 98762452, rating: 3)

      expect(song_1.songs_with_same_rating).to eq([song_2, song_3, song_4])
    end
  end
end
