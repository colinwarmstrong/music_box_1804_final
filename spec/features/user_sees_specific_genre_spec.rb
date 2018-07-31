require 'rails_helper'

describe "A user visits '/genres/:id'" do
  describe 'as a visitor' do
    it 'they see all songs associated with that genre' do
      genre = Genre.create(name: 'Rock')

    end
  end
end
