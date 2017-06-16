require 'features_helper'

describe 'Add a book' do
  after do
    BookRepository.new.clear
  end

  it 'can create a new book' do
    page.visit '/books/new'

    within 'form#book-form' do
      page.fill_in 'Title',  with: 'New book'
      page.fill_in 'Author', with: 'Some author'

      page.click_button 'Create'
    end

    expect(current_path).to eq('/books')
  end

  it 'displays list of errors when params contains errors' do
    visit '/books/new'

    within 'form#book-form' do
      click_button 'Create'
    end

    expect(current_path).to eq('/books')
    expect(page.body).to include('There was a problem with your submission')
    expect(page.body).to include('Title must be filled')
    expect(page.body).to include('Author must be filled')
  end
end
