require 'rails_helper'

describe "A user sees visits '/genres'" do
  describe "As a visitor" do
    it 'they see all genres in the database' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      genre_3 = Genre.create(name: 'Disco')

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(genre_3.name)
      expect(page).to_not have_content('Create New Genre')
    end
  end
  describe "As an admin user" do
    before :each do
      user = User.create(username: 'admin', password: 'password', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'they see the same information visitors see and a form to create a new genre' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      genre_3 = Genre.create(name: 'Disco')

      visit genres_path

      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(genre_3.name)

      within '.new-genre-form' do
        expect(page).to have_content('Create New Genre')
        expect(page).to have_content('Name')
      end
    end
    it 'they can create a new genre by filling out the form' do
      genre_1 = Genre.create(name: 'Rock')
      genre_2 = Genre.create(name: 'Funk')
      genre_3 = Genre.create(name: 'Disco')

      visit genres_path

      new_genre = 'Techno'

      fill_in :genre_name, with: new_genre
      click_on 'Create Genre'

      expect(current_path).to eq(genres_path)
      expect(page).to have_content(new_genre)
      expect(page).to have_content(genre_1.name)
      expect(page).to have_content(genre_2.name)
      expect(page).to have_content(genre_3.name)
    end
  end
end
