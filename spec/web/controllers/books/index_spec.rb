require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/index'

RSpec.describe Web::Controllers::Books::Index do
  let(:action) { Web::Controllers::Books::Index.new }
  let(:params) { Hash[] }
  let(:repository) { BookRepository.new }

  subject { action.call(params) }

  before do
    repository.clear

    @book = repository.create(title: 'TDD', author: 'Kent Beck')
  end

  it { is_expected.to have_http_status(200) }

  it 'exposes all books' do
    action.call(params)
    expect(action.exposures[:books]).to eq [@book]
  end
end
