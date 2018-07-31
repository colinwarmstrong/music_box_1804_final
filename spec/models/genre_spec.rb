require 'rails_helper'

describe Genre, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should have_many :song_genres}
    it {should have_many :songs}
  end
end
