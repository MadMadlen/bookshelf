require_relative '../../../../apps/web/controllers/books/create'

RSpec.describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }
  let(:repository) { BookRepository.new }

  before { repository.clear }
  subject { action.call(params) }

  context 'with valid params' do
    let(:params) { Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm' }] }

    it 'creates a new book' do
      subject
      book = repository.last

      expect(book.id).to_not be nil
      expect(book.title).to eq(params.dig(:book, :title))
    end

    it 'redirects the user to the books listing' do
      subject

      is_expected.to have_http_status(302)
      expect(subject[1]['Location']).to eq '/books'
    end
  end

  context 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it { is_expected.to have_http_status(422) }
    it do
      subject

      errors = action.params.errors

      expect(errors[:book][:title]).to include 'is missing'
      expect(errors[:book][:author]).to include 'is missing'
    end
  end
end
