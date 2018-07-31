require 'rails_helper'

describe "A visitor visits '/genres'" do
  it 'they see all genres in the database' do
    genre_1 = Genre.create(name: 'Rock')
    genre_2 = Genre.create(name: 'Funk')
    genre_3 = Genre.create(name: 'Disco')

    visit genres_path

    expect(page).to have_content(genre_1.name)
    expect(page).to have_content(genre_2.name)
    expect(page).to have_content(genre_3.name)
  end
end
