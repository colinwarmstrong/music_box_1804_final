require 'rails_helper'

describe Song, type: :model do
  describe 'validations' do
    it{should validate_presence_of(:title)}
    it{should validate_presence_of(:length)}
    it{should validate_presence_of(:play_count)}
    it{should have_many :song_genres}
    it{should have_many :genres}  
  end

  describe 'relationships' do
    it{should belong_to(:artist)}
  end
end
